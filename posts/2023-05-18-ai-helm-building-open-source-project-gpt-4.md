---
blurb: I've mostly been a LLM and GPT skeptic. Every so often I'd bang my head against
  ChatGPT, and it usually gave me junk. I'd wander off grumbling things jaded engineers
  grumble.
changelog:
- author: Chris Riccomini
  date: '2025-02-11T03:37:54+08:00'
  hash: d19b4fe21deb3d05c34bfd4c3bc577ce829929e5
  message: Fix redirects
- author: Chris Riccomini
  date: '2025-02-11T02:34:29+08:00'
  hash: e09bef81474c5cfb2159faeb6f5fa5a22d523737
  message: Migrate to markupdown (#1)
created_at: '2023-05-18T00:00:00Z'
link: /posts/2023-05-18-ai-helm-building-open-source-project-gpt-4
redirects_from: /essays/helm-building-open-source-project-gpt-4
template: post
title: 'AI at the Helm: Building an Entire Open Source Project With GPT-4'
toc:
- level: 1
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4
  title: 'AI at the Helm: Building an Entire Open Source Project With GPT-4'
- level: 2
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4
  title: Key Lessons from Building with GPT-4
- level: 3
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4_start-small
  title: Start Small
- level: 3
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4_code-test-repeat
  title: Code, Test, Repeat
- level: 3
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4_gpt-4-forgets
  title: GPT-4 Forgets
- level: 3
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4_show-changes-only
  title: Show Changes Only
- level: 3
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4_iterate
  title: Iterate
- level: 3
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4_great-for-grunt-work
  title: Great for Grunt Work
- level: 3
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4_best-for-pure-projects
  title: Best for 'Pure' Projects
- level: 3
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_key-lessons-from-building-with-gpt-4_keep-gpt-3-5-handy
  title: Keep GPT-3.5 Handy
- level: 2
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_why-not-github-copilot
  title: Why Not Github Copilot?
- level: 2
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_future-work
  title: Future work
- level: 2
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_conclusion
  title: Conclusion
- level: 2
  slug: ai-at-the-helm-building-an-entire-open-source-project-with-gpt-4_addendum
  title: Addendum
updated_at: '2025-02-11T03:37:54+08:00'
---

# AI at the Helm: Building an Entire Open Source Project With GPT-4

I've mostly been a [LLM](https://en.wikipedia.org/wiki/Large_language_model) and [GPT](https://en.wikipedia.org/wiki/Generative_pre-trained_transformer) skeptic. Every so often I'd bang my head against [ChatGPT](https://openai.com/blog/chatgpt), and it usually gave me junk. I'd wander off grumbling things jaded engineers grumble.

Then I payed for OpenAI's [GPT-4](https://openai.com/research/gpt-4) upgrade. GPT-4 actually seemed to work, so I decided to see how far I could push it. Could I write an entire open source project with GPT-4? Turns out, I could.

I had GPT-4 build me [Twister](https://github.com/criccomini/twister), a Java library that converts Avro and Protobuf data to and from Java POJOs. Nearly every element--code, docs, commit messages, tests, its README.md, even this blog post--was written by GPT-4.

This post isn't about Twister, though. It's about how I learned to use ChatGPT effectively to write not just tests and documentation, but code.

## Key Lessons from Building with GPT-4

Here's what I learned:

- **Start Small**: Don't aim for complex features right away.
- **Code, Test, Repeat**: Follow the same patterns you use to write code.
- **GPT-4 Forgets**: Always re-paste the code you want to update.
- **Show Changes Only**: Helps you get answers faster. GPT-4 can be slow.
- **Iterate**: Don't write GPT-4 off at first mistake. Keep asking it to correct.
- **Great for Grunt Work**: GPT-4 shines with tests, docs, and commit messages.
- **Best for 'Pure' Projects**: Less business logic, like Twister, suits GPT-4.
- **Keep GPT-3.5 Handy**: Good for simpler tasks. Saves on GPT-4 quota.

### Start Small

Break down tasks. Ask GPT-4 to build simple code changes at first. With Twister, I would have it build support for basic primitives (int, float, string, etc.) first. Once I got that working, I'd ask it to add support for complex types (maps, lists, enums, etc.).

### Code, Test, Repeat

The best pattern I found was:

1. Ask GPT-4 to write code.
2. Ask GPT-4 to write a test for the code it'd written.
3. Ask GPT-4 to fix the failed test(s) if they don't pass.

Flipping 1 and 2 ([TDD](https://en.wikipedia.org/wiki/Test-driven_development)) works, too

If you spot bugs, ask it to write tests exposing the bug. Then ask it to fix the test. The template I used for this loop was:

```
Given this code:
...

And this test:
...

I get this error:
...

Can you fix this?
```

### GPT-4 Forgets

GPT-4 has a bad long-term memory. I found it did much better when I kept re-pasting my code into the prompt on ever iteration. There is a limit to the input size, so you have to get creative sometimes to fit relevant snippets in.

### Show Changes Only

GPT-4 can be slow. To speed it up, request that it shows you only the code that's changed.

### Iterate

Don't dismiss GPT-4 at first error, even if it says silly things. Ask for corrections.

### Great for Grunt Work

GPT-4 excels at mundane tasks. I'm convinced everyone should use it for tests, doc strings, and commit messages.

### Best for 'Pure' Projects

Twister is a pretty pure computer science project; there isn't any real "business logic". I think GPT-4 does better at this kind of work.

### Keep GPT-3.5 Handy

Use GPT-3.5 for simpler tasks. Saves you on your GPT-4 quota.

## Why Not Github Copilot?

Copilot employs GPT-3.5. Compared to GPT-4, it is noticeably less effective. Copilot X offers improvements, yet it's tied to VisualStudio and VSCode. However, IntelliJ IDE is way more pleasant for Java than VSCode. So I just used ChatGPT. In the long run, IDE integration will certainly improve. Yet, for now, GPT-4 offered the optimal solution for Twister.

## Future work

The Twister library is a small project right now. I want to add:

* Avro default support
* Avro logical type support
* Protobuf WKT support
* Avro Record ➡️ Map wrapper
* Protobuf Message ➡️ Map wrapper
* .proto ➡️ Protobuf Descriptor converter
* JDBC row ➡️ Map wrapper

I'll continue having GPT write the code in this library. The experiment continues!

## Conclusion

Though this post is about building with GPT-4, I want to re-iterate that [Twister](https://github.com/criccomini/twister) is a real project that I actually want people to use. It's a pretty cool library. If you're a Java developer dealing with Protobuf or Avro, check it out! Contributions are welcome, too (whether from GPT-4 or humans).

## Addendum

Here's the prompt I used to generate this blog post:

> The blog post should focus on my experience using GPT-4 to write an entire library.
> 
> The post should also talk about GPT-4 tricks I learned while building this project:
> 
> - Start small (don't ask GPT-4 to write all features in a class at once)
> - Ask GPT for a basic class, then ask it to write a test for the class. If the tests fail, tell GPT, and have it fix the tests. Then go back to the basic class and ask GPT-4 to add the next feature. Rinse and repeat.
> - Always re-paste the code you want GPT-4 to update. It has bad long-term memory. I frequently use a 2 part template: "Given this code: ... Can you update it to ..."
> - Tell it to just show changes, not the complete code. GPT-4 is slow, so telling it to skip unchanged code helps get you answers faster.
> - Don't be afraid to iterate. Many people get a response from GPT-4, and if it's wrong, they declare that it sucks. Instead, keep asking it to fix things.
> - GPT-4 is really good for grunt work (tests, docs, commit messages)
> - GPT-4 is also really good for more "pure" projects like Twister, where it doesn't have to understand a lot of business logic.
> - Keep a GPT-4 and a GPT-3.5 window open, so you can bounce to the GPT-3.5 window for more simple work. This will save you on your GPT-4 quota (currently 25 prompts per-3h window).
> 
> The blog post style should be:
> 
> 1. Matter-of-fact.
> 2. No sentence should be more than 12 words.
> 3. Include links to external sites where appropriate.
> 4. Written in first-person.
> 5. The post should include a bullet-point list of the tips near the introduction.
> 6. The post should be written in markdown.
> 7. The post should include a catchy title that will get attention on Hacker news.
> 8. The post should include a section for each bullet point in the intro.
> 9. The intro should say that the the code, docs, git commit messages, tests, README.md, and even this blog post were all written with GPT-4.

I pasted in an rough outline with some notes before this prompt.