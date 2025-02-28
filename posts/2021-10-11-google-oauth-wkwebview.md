---
blurb: When I built WANT, I avoided adding OAuth2 sign-ins at first; I knew it'd be
  a headache. Instead, I used Devise, Rails's standard authentication framework, to
  handle email-based sign-ins.
changelog:
- author: Chris Riccomini
  date: '2025-02-11T03:37:54+08:00'
  hash: d19b4fe21deb3d05c34bfd4c3bc577ce829929e5
  message: Fix redirects
- author: Chris Riccomini
  date: '2025-02-11T02:34:29+08:00'
  hash: e09bef81474c5cfb2159faeb6f5fa5a22d523737
  message: Migrate to markupdown (#1)
created_at: '2021-10-11T00:00:00Z'
link: /posts/2021-10-11-google-oauth-wkwebview
redirects_from: /essays/google-oauth-wkwebview
template: post
title: OAuth "Sign In With Google" in a WkWebView
toc:
- level: 1
  slug: oauth-sign-in-with-google-in-a-wkwebview
  title: OAuth &quot;Sign In With Google&quot; in a WkWebView
updated_at: '2025-02-11T03:37:54+08:00'
---

# OAuth "Sign In With Google" in a WkWebView

When I built [WANT](https://want.app), I avoided adding OAuth2 sign-ins at first; I knew it'd be a headache. Instead, I used [Devise](https://github.com/heartcombo/devise), [Rails](https://rubyonrails.org/)'s standard authentication framework, to handle email-based sign-ins.

Some users want to sign in using Google or Apple, though. I eventually added [OmniAuth](https://github.com/omniauth/omniauth) to [WANT](https://want.app) with the [omniauth-google-oauth2](https://github.com/zquestz/omniauth-google-oauth2) and [omniauth-apple](https://github.com/nhosoya/omniauth-apple) providers.

Then I built an iOS mobile app in Swift with Swift UI. The app was a [WkWebView](https://developer.apple.com/documentation/webkit/wkwebview) that loaded [https://want.app](https://want.app). This is where my authentication problems with Google started.

I was seeing this error message when I tried to authenticate with Google in the iOS app:

> **Error: disallowed_useragent**
>
> This user-agent is not permitted to make OAuth authorisation request to Google as it is classified as an embedded user-agent (also known as a web-view). Per our policy, only browsers are permitted to make authorisation requests to Google. We offer several libraries and samples for native apps to perform authorisation request in browser.


Google doesn't want users authenticating inside embedded browsers like WkWebView. WkWebView allows developers to inject Javascript, read cookies, and otherwise manipulate the browser contents. Such power could enable a nefarious developer to read usernames and passwords as they're entered into [https://accounts.google.com](https://accounts.google.com) for the OAuth flow.

[Most Stack Overflow answers](https://stackoverflow.com/questions/53135551/google-disallowed-useragent-in-wkwebview) tell you to programmatically change the WkWebView user-agent, which Google is using to detect embedded browsers.

```swift
webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1";
```

This works, but is a violation of Google's terms of service.

Auth0 documents better alternatives in their post, [Google Blocks OAuth Requests Made Via Embedded Browsers
](https://auth0.com/blog/google-blocks-oauth-requests-from-embedded-browsers/). But all listed solutions all involve an SDK.

I'm not a mobile developer by trade, and I didn't want to deal with the complexity of a mobile OAuth2 implementation. I already had OAuth working on my website, and I wanted to use it.

I figured out that you can simply redirect users to Safari for authentication, and use [universal links](https://developer.apple.com/ios/universal-links/) to redirect users back to your app (and WkWebView) once they've authenticated. This is how the flow looks:

<iframe width="560" height="315" src="https://www.youtube.com/embed/5gaVvWc6zyk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

This can be done with just a few links of Swift! And it doesn't violate Google's terms of service, since the Google authentication takes place in a standard Safari browser.

The tap to log into Google redirects users to Safari. This can be done in a [WkNavigationDelegate](https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455627-webview) method

```swift
func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
  if let url = webView.url, url.absoluteString.starts(with: "https://accounts.google.com") {
    UIApplication.shared.open(url, options: [:])
  }
}
```

The `webView` method is invoked when the WkWebView receives a redirect. If the URL points to [https://accounts.google.com](https://accounts.google.com), the link is opened in the phone's default browser.

Once in the default browser, the user can authenticate using their Google account. Best of all, if the user is already logged into Google (as in the video above), the user simply taps the account they wish to log in with.

From here, Google redirects the user back to your callback. This is where universal linking comes in. In my case, the callback URL is under the [https://want.app](https://want.app) domain--the callback that OmniAuth needs.

Using [universal links](https://developer.apple.com/library/archive/documentation/General/Conceptual/AppSearch/UniversalLinks.html), we can open the redirected callback URL back in the app. Follow the instructions in the previous link to set up universal links for your app. Once that's done, you need to write some code to open the redirected URL in your app's WkWebView.

First, receive the URL and send a notification.

```swift
ContentView()
  .onOpenURL { (url) in
    NotificationCenter
      .default
      .post(name: NSNotification.Name("com.app.ios.application.url.opened"), object: nil, userInfo: ["url": url])
}
```

My app uses [Swift UI](https://developer.apple.com/xcode/swiftui/), so it's using `onOpenURL`. You'll have to Google around if you're using [UIKit](https://developer.apple.com/documentation/uikit/), but it's straight forward.

Elsewhere in your app (probably in the controller with the WkWebView), receive the URL notification.

```swift
NotificationCenter.default.addObserver(self, selector: #selector(self.urlLoaded(notification:)), name: Notification.Name("com.app.ios.application.url.opened"), object: nil)
```

And load the new URL.

```swift
@objc func urlLoaded(notification: Notification) {
  let url = notification.userInfo!["url"]! as! URL
  self.webView.load(URLRequest(url: url))
}
```

Now, any URL that your app receives will load into the WkWebView. If you only want to handle callback URLs, not all URLs, you can modify the code to filter out URLs that don't match.

This approach works because Google's OAuth implementation redirects back to your server using a simple `GET` request. Forwarding this `GET` request on to your WkWebView via universal linking means that the OAuth2 callback is loaded in your WkWebView. Loading the callback in your WkWebView means your websites session and cookie data will be stored in the web view, not in Safari's cookie space. 

(NOTE: [This Stack Overflow post](https://stackoverflow.com/questions/45098927/how-to-implement-google-login-in-a-wkwebview-switching-to-sfsafariviewcontroller) served as inspiration for my solution.)