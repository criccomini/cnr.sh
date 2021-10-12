---
title: Implement OAuth "Sign In With Google" in WkWebView
date: October 11, 2021
---

If you're seeing an error like this:

> Error: disallowed_useragent

When trying to use OAuth2 to sign in with Google in an iOS WkWebView, this is because Google no longer allows WkWebViews to go through its OAuth flow. The logic is that WkWebView allows developers to inject Javascript, read cookies, and otherwise manipulate the browser contents. Such control means developers can theoretically read Google usernames and passwords as they're entired into https://accounts.google.com for the OAuth flow.

[Most Stack Overflow answers](https://stackoverflow.com/questions/53135551/google-disallowed-useragent-in-wkwebview) suggest that you change the WkWebView user agent. This works, but is a violation of Google's terms of service.

Auth0 documents alternative implementations in their blog post, [Google Blocks OAuth Requests Made Via Embedded Browsers
](https://auth0.com/blog/google-blocks-oauth-requests-from-embedded-browsers/). These solutions all involve some SDK.

I didn't want to deal with SDKs and client and server IDs. Instead, I figured out that you can simply redirect users to Safari for the authentication, and use universal linking to redirect users back to your app (and WkWebView) once they've authenticated.

This approach works because Google's OAuth implementation redirects back to your server using a simple GET request. Forwarding this GET request on to your WkWebView means that the OAuth2 authentication happens with cookies in your WkWebView (not those that are in Safari).

The advantage of this approach is that you don't need an SDKs, and very little Swift/Objective-C. The flow to implement this looks like:

1. Detect when WkWebView is being redirected to https://accounts.google.com
2. Open the redirected link in Safari
3. Implement universal links in your app
4. Open the OAuth2 Google redirect link from Safari back in your WkWebView

The flow looks like this:

1. User clicks "Sign in with Google" in your WkWebView.
2. App opens https://accounts.google.com OAuth link in Safari.
3. User selects their Google account.
4. Google redirects to your OAuth backend.
5. iOS detects the universal

[This Stack Overflow post](https://stackoverflow.com/questions/45098927/how-to-implement-google-login-in-a-wkwebview-switching-to-sfsafariviewcontroller) gives us a hint at what to do.