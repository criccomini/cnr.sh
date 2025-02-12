# Comparing Apache, CNCF, and Commonhaus

I've used open source projects for over 30 years and contributed for about 20 of those. My first interaction with an open source foundation was with [Apache](https://apache.org/) when I began working with Apache Hadoop in 2008. Since then, I have contributed to many Apache projects, created Apache Samza, and was mentor and project champion for Apache Airflow. I'm also on the Apache PMC. I have less experience with [CNCF](http://cncf.io/), though I did apply to donate [SlateDB](https://github.com/slatedb/slatedb). I later [withdrew](https://github.com/cncf/sandbox/issues/114) SlateDB's CNCF application and donated the project to [Commonhaus](https://www.commonhaus.org/) instead. I'm frequently asked for guidance on which open source foundation to donate a project to. I've decided to share my thoughts in this post.

Open source foundations offer a wide range of services. Such services commonly include legal guidance, trademark management, a governance structure, a code of conduct, software infrastructure, funding, grants, community support, marketing, conferences, and a lot more. Some, like CNCF and Apache, are quite expansive. Others, like Commonhaus, are more minimal. Which foundation is right for you depends on your project's needs.

**_(skip to the bottom for a tl;dr)_**

## Apache

Apache is the most well known of the open source foundations. It offers most of the services listed above. It's also home to many successful projects, including Apache Kafka, Apache Flink, Apache Hadoop, Apache Spark, and Apache Airflow. The foundation adopts [The Apache Way](https://www.apache.org/theapacheway/), a set of values and principles that guide operations and decision-making.

I'm fortunate to have worked with Apache as my first foundation. I learned how to effectively manage a large open source project. There is much to consider: licensing, release process, governance, trademarking, issue management, security, communication, and so on. Apache provides you with a framework to manage your project.

Apache's framework is rather rigid, though. The Apache Way requires consensus decision making, open communication, earned authority, oversight from the ASF board, and so on. Even if you like The Apache Way, the requirements often get entangled with burdensome implementation details. Board oversight, for example, requires quarterly board reports that must be submitted through a [bizarre versioning process](https://www.apache.org/foundation/board/reporting). Open communication has become synonymous with forced mailing list and JIRA usage. (They have begrudgingly adopted some Github support, but not without a [lot](https://infra.apache.org/apache-github.html) [of](https://cwiki.apache.org/confluence/display/MAVEN/JIRA+to+GitHub+Issues+switching) [friction](https://github.com/apache/infrastructure-asfyaml).) Release process requirements are also annoying. Xuanwo wrote about this in, [What did ASF do wrong?](https://xuanwo.io/2024/09-what-did-asf-do-wrong/), which I highly recommend reading:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">What aspects of Apache infra do you find problematic? The requirement to use mailing lists? The LDAP account system? Static-only websites for projects? etc.<br><br>What are the pain point(s) that you see with the ASF Infra?<br><br>(genuinely curious; I&#39;m part of Infra there)</p>&mdash; Greg Stein (@gstein) <a href="https://twitter.com/gstein/status/1817149711117123938?ref_src=twsrc%5Etfw">July 27, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

One of the paradoxes of Apache is that it does such a good job educating developers that they eventually outgrow it. Once I became more adept with open source project management, I found that I wanted to customize it to my project's needs. I was educated enough to decide which license was appropriate, how communication should be handled (using Discord, for example), how consensus policies should work, whether companies should be involved in roadmap planning, and so on.

> Learn the rules like a pro, so you can break them like an artist
> --Picasso

Apache simply doesn't allow you to make these choices. As my work on Airflow died down, I swore I would never do another foundation. Instead, I committed to being a [benevolent dictator for life](https://en.wikipedia.org/wiki/Benevolent_dictator_for_life) (BDFL) for all future projects. The BDFL model was popularized by [Guido van Rossum](https://en.wikipedia.org/wiki/Guido_van_Rossum), creator of Python. Many successful projects have BDFs including Ethereum, Clojure, Django, Zig, Ruby, and even Linux.

My commitment to BDFL conflated two things, though. A benevolent dictator is a governance model, not a foundation. Even Python, which pioneered the BDFL model, has the [Python Software Foundation](https://www.python.org/psf-landing/). If you go with the BDFL model, you still need to manage and promote your project--the stuff I listed above.

[Rohan Desai](https://www.linkedin.com/in/rohanpd) (co-founder of [Responsive](https://responsive.dev/)) and I bumped into this reality when we started SlateDB last year. I had planned to be BDFL for the project. I was independent of any company and was committed to keeping the project open source and not for profit. As the project grew, I realized I wanted two things:

- Help with trademarks, IP, and legal matters
- A signal that SlateDB was safe for companies to use

I explicitly did not want The Apache Way. In particular, Apache outright denies any direct company involvement; The Apache Way says, "individuals participate at the ASF, not organizations." This is a farce. Many of their projects are dominated by a single company. I wanted SlateDB to welcome companies as a partner, not a threat. Moreover, I didn't want to deal with the frustrating infrastructure requirements I listed above. 

## CNCF

I began to investigate CNCF.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Anyone out there have experience with CNCF? Would recommend? Thoughts vs. Apache?<br><br>I&#39;m lookin for a home for SlateDB. Ideally something with a lighter touch than Apache. Main goal is a foundation to own the code and a governance model so multiple companies can commit.<br><br>/cc <a href="https://twitter.com/wm?ref_src=twsrc%5Etfw">@wm</a></p>&mdash; Chris (@criccomini) <a href="https://twitter.com/criccomini/status/1816993195001274433?ref_src=twsrc%5Etfw">July 27, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[William Morgan](https://bsky.app/profile/williammorgan.me), co-founder of [Buoyant](https://buoyant.io/) seemed to have some good things to say about it. [Nick Schrock](https://twitter.com/schrockn) also recommended it. [Chris Aniszczyk](https://bsky.app/profile/cra.dev) even messaged me to offer his support.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Very positive. Bring your own governance is real. Apache is ridiculously heavy. They force you to use Jira!</p>&mdash; Nick Schrock (@schrockn) <a href="https://twitter.com/schrockn/status/1816998650758975748?ref_src=twsrc%5Etfw">July 27, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Though CNCF is [vendor neutral](https://contribute.cncf.io/maintainers/community/vendor-neutrality/), they at least acknowledged that companies and their open source projects are inter-related. The CNCF also offers excellent [templates](https://contribute.cncf.io/maintainers/templates/) for project governance and [guidance on security](https://contribute.cncf.io/maintainers/security/). These templates and guidance seemed much more flexible than Apache. I filled out the [sandbox form](https://github.com/cncf/sandbox/issues/114).

Unfortunately, I found much of the same bureaucracy that Apache suffered from. There are a dizzying amount of acronyms to learn ([TOCs](https://www.cncf.io/people/technical-oversight-committee/), [TAGs](https://github.com/cncf/toc/tree/main/tags), and so on). There are [four different stages](https://github.com/cncf/toc/blob/main/process/README.md#introduction) to a CNCF project's life cycle: sandbox, incubation, graduation, and archive--more than Apache has! We were asked to present on the project at a CNCF TAG meeting, which we were happy to do. But much of the meeting and sandbox process focused on bizarre questions like whether SlateDB was "cloud native." The sandbox application took much longer than I expected (it was still ongoing after 3 months). I've also heard (though did not experience) a pay-to-play atmosphere.

My takeaway was that CNCF is Apache with better infrastructure. There's nothing wrong with this, but it's not what I wanted. I decided to withdraw the application and look for another option. I also gave my feedback to Chris.

<blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:i4pinuo42zwnjscvc2islvqy/app.bsky.feed.post/3lbx3fdhkzc2e" data-bluesky-cid="bafyreihtpvdadqvhuysl5nw5tw2dsqvqay7enqopjcuhcxeoo4j3dhhwua"><p lang="en">not sure another &quot;no frills&quot; foundation without proper fundraising mechanisms to support projects over the long term is really needed but would have loved to seen SlateDB in CNCF as the fit makes a lot more sense imho</p>&mdash; Chris Aniszczyk (<a href="https://bsky.app/profile/did:plc:i4pinuo42zwnjscvc2islvqy?ref_src=embed">@cra.dev</a>) <a href="https://bsky.app/profile/did:plc:i4pinuo42zwnjscvc2islvqy/post/3lbx3fdhkzc2e?ref_src=embed">Nov 27, 2024 at 9:31 AM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>

<blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:cwx2zxldt3uxciob3nxzhkzr/app.bsky.feed.post/3lbx3lgrd7c2v" data-bluesky-cid="bafyreid5or2xmlmqg37dzx45k2xms5gkog4r4chcwlf4eu24yvun33psje"><p lang="en">I applied to CNCF. After several months, no movement, and there was debate about id SlateDB was &quot;cloud native&quot;. It was a very poor experience.<br><br><a href="https://bsky.app/profile/did:plc:cwx2zxldt3uxciob3nxzhkzr/post/3lbx3lgrd7c2v?ref_src=embed">[image or embed]</a></p>&mdash; Chris (<a href="https://bsky.app/profile/did:plc:cwx2zxldt3uxciob3nxzhkzr?ref_src=embed">@chris.blue</a>) <a href="https://bsky.app/profile/did:plc:cwx2zxldt3uxciob3nxzhkzr/post/3lbx3lgrd7c2v?ref_src=embed">Nov 27, 2024 at 9:35 AM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>

<blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:i4pinuo42zwnjscvc2islvqy/app.bsky.feed.post/3lbx3tnpk3k2j" data-bluesky-cid="bafyreicegoqjeh2te26zl76upsvvqcguzrbsrnf4rg6bqmy5ftrsukbxty"><p lang="en">there is a process to follow including questions around scope, timelines that should be clear here github.com/cncf/toc/blo... - if you expected things to move faster than that&#x27;s feedback I&#x27;ll take back to the TOC - I&#x27;m all for making things better on the CNCF/LF side<br><br><a href="https://bsky.app/profile/did:plc:i4pinuo42zwnjscvc2islvqy/post/3lbx3tnpk3k2j?ref_src=embed">[image or embed]</a></p>&mdash; Chris Aniszczyk (<a href="https://bsky.app/profile/did:plc:i4pinuo42zwnjscvc2islvqy?ref_src=embed">@cra.dev</a>) <a href="https://bsky.app/profile/did:plc:i4pinuo42zwnjscvc2islvqy/post/3lbx3tnpk3k2j?ref_src=embed">Nov 27, 2024 at 9:39 AM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>

<blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:cwx2zxldt3uxciob3nxzhkzr/app.bsky.feed.post/3lbx3zind3c2v" data-bluesky-cid="bafyreicyvwp5li5vsfur6bz23sglgtmzj3fnrdmheoajvl7vk2vrkwk4w4"><p lang="en">👍 mostly I found the nit picking about whether slatedb was cloud native to be a huge turn off. Sees patently obvious to me. Gave me strong Apache bureaucracy vibes. Exactly what I was trying to avoid.</p>&mdash; Chris (<a href="https://bsky.app/profile/did:plc:cwx2zxldt3uxciob3nxzhkzr?ref_src=embed">@chris.blue</a>) <a href="https://bsky.app/profile/did:plc:cwx2zxldt3uxciob3nxzhkzr/post/3lbx3zind3c2v?ref_src=embed">Nov 27, 2024 at 9:42 AM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>

<blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:cwx2zxldt3uxciob3nxzhkzr/app.bsky.feed.post/3lbx4dcsm5s26" data-bluesky-cid="bafyreiegqrk7rbdg7wb4gitkrcljm362pn2dtzlkllogephhcvybbr7iie"><p lang="en">My feedback regarding speed is that CNCF some how managed to have more project maturity layers than Apache, yet sandbox feels just as heavy as Apache&#x27;s Incubator. IMO, sandbox should be way faster and lighter touch. Save more of this stuff for Incubator.</p>&mdash; Chris (<a href="https://bsky.app/profile/did:plc:cwx2zxldt3uxciob3nxzhkzr?ref_src=embed">@chris.blue</a>) <a href="https://bsky.app/profile/did:plc:cwx2zxldt3uxciob3nxzhkzr/post/3lbx4dcsm5s26?ref_src=embed">Nov 27, 2024 at 9:48 AM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>

## Commonhaus

[Gunnar Morling](https://www.morling.dev/) had been pushing me toward [Commonhaus](https://www.commonhaus.org/). When [Debezium joined](https://www.morling.dev/blog/thoughts-on-moving-debezium-to-commonhaus-foundation/), I decided to give it a closer look. I loved [what I found](https://www.commonhaus.org/about/). Their two first principles are:

- Honor project and community identity
  We celebrate the distinctiveness of each project and its community, and respect their right to evolve according to their own vision and leadership.
- Offer guidance and support instead of imposing mandates
  Our role is to provide support and guidance, facilitating project growth without overbearing governance. By offering resources, connections, and expertise, we help projects navigate challenges while ensuring they remain in control of their path.

They also [encourage](https://github.com/commonhaus/foundation/tree/main?tab=readme-ov-file#what-sets-commonhaus-apart), "minimum viable governance." While Apache had a heavy process and poor infrastructure, and CNCF had a heavy process and good infrastructure, Commonhaus seemed to have a light process and no infrastructure. This was what I was looking for. A foundation that could help with my legal requirements, own trademarks, and give me guidance _when I asked for it_. They also offer license flexibility; they'll support any [OSI-approved license](https://www.commonhaus.org/policies/ip-policy/). Vendors that want to use [AGPL](https://opensource.org/license/agpl-v3) or [GPL](https://opensource.org/license/gpl-3-0) are welcome. License flexibility wasn't a requirement for us, but it's worth noting. I applied for SlateDB and was quickly accepted.

It's not all roses, of course. Commonhaus is very young, so it could grow a lot of bureaucracy. Some of this is inevitable; trademark ownership requires some measure of control over the project. The foundation also seems fairly dependent on Red Hat. As Chris pointed out above, they need to figure out sustainable funding. Where Apache became synonymous with Java and big data, and CNCF explicitly focused on cloud native technology, Commonhaus might evolve some specific focus that doesn't suit SlateDB. Thus far, it's been a great experience, though.

## tl;dr

So, which foundation is right for you? As staff software engineers say, "it depends". I started to write out a full-fledged decision tree, but there are too many variables to consider. Instead, here's some vibes-based guidance:

- Always start as a BDFL.
- Stay a BDFL as long as your project is new, small, or doesn't have companies depending on it.
- Never use Apache.
- Use CNCF if you don't know what you're doing, if you want help with branding and marketing, or if you're backed by a company that wants to pay CNCF.
- Use Commonhaus if you know what you're doing and want flexibility. If you're a SaaS vendor with an AGPL license, use Commonhaus.

This list is non-exhaustive. I'm sure there will be much to quibble over.