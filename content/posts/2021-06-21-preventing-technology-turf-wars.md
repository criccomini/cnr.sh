---
created_at: '2021-06-21T00:00:00Z'
redirects_from: /essays/preventing-technology-turf-wars
---

# Preventing Technology Turf Wars

The new [SaaS Slack](https://join.slack.com/t/saas-hgv7803/shared_invite/zt-qwvrywyr-8DmSpEzBiSWD2WQuB9r9pw) (it’s awesome; you should totally join it) had a good question on technical decision processes:

> How is technical decision making structured in your organization? Even more interesting, in a way, how has that evolved over time (e.g. as a function of headcount)?
> 
> Decisions around topics like programming languages, API standards, architectural patterns, etc. Especially when there is previous art around and converging on a standard requires backfilling/migrating existing systems. 

There are many things to consider when adding a new technology to a stack: cost, existing technologies, security and compliance features, team ownership and support, and more. We engineers like to argue about technology merits, but many conflicts that I see stem from turf wars over domain and technology ownership.

The problem looks like this: Team A wants to use a new "build system" (substitute build system for any technology). There are usually three versions of such a scenario:

1. Team B is responsible for build systems, and they already support one.
2. Team B is responsible for build systems, but they don’t support one yet.
3. No team is currently responsible for build systems.

\(a\) and (b) are more common than (c), but all three patterns lead to disputes. Ownership fights are toxic and can have a lasting negative impact on team culture, engagement, and ultimately attrition. Proactively managing team dynamics when adding new technology can save you a lot of heartache down the road. Let’s dig into these three scenarios.

## Team B "Owns" the Problem Space and Has a Solution

In scenario (a), an existing team already owns the problem space (build systems) and has an existing solution ("We use Bazel! Just use it!"). Discussions focus on the tradeoffs between existing solutions and the newly proposed technology, and on team ownership if the newly proposed technology is adopted.

Follow [boring technology practices](http://boringtechnology.club/) and [a16z-style](https://a16z.com/2012/12/18/programming-your-culture/), "the new product must be 10x better," policies. If a new technology is marginally better than the existing one, go with the existing one. Look for complementary technologies. Python and Java work well together because they are opposites across a number of dimensions: virtual machine-based vs. interpreted, typed vs. not typed, good for services vs. good for tools, and so on.

The [WePay design review process](https://wecode.wepay.com/posts/effective-software-design-documents) has been effective at managing tradeoff discussions and keeping teams in sync. Development teams sometimes complain that design reviews take too much time. We instituted two policies to help: design reviews are time boxed and reviews are optional when existing technologies (and architectures) are used.

If new technology is adopted, you face an ownership question: is it Team A’s or Team B’s responsibility to own the new thing? Many factors such as resourcing, skill set, and team roadmaps must be considered. I like an approver-based handoff model, which I discuss in scenario (b), below.

## Team B "Owns" the Problem Space but has No Solution

Scenario (b) is where things normally get messiest. Team B owns the problem space (build systems), but doesn’t yet have a solution available. Team B normally responds by: 

* Trying to kill Team A’s proposal because they have some vaporware on the roadmap about how they’re going to roll out a build system in 18 months.
* Trying to take control of Team A’s proposal and roll out the proposed build system company-wide, thereby slowing Team A’s velocity and ownership.

I prefer a partnership approach. Team A is fully responsible for rolling out their solution, but Team B acts as an advisor. Team B normally has experience that Team A lacks in the build system area, so they can eliminate gotchas. Having an advisory role also means that Team B knows what’s going on if they eventually inherit the solution.

Advisory styles vary. Sometimes an advising team functions as an _approver_ (in the [DACI](https://www.atlassian.com/team-playbook/plays/daci) management-speak sense). Other times, advisors are simply kept _informed_ of progress and plans so they can give suggestions. Advisor teams might _contribute_ some engineering time, too. The right pattern depends on the context. My favorite approach is to keep advisors informed so they can give hints and suggestions.

When other teams discover Team A’s solution and want to use it, ownership and handoff discussions between Team A and Team B can occur. Team A usually doesn’t want to support their solution for other teams, so the relationship inverts. Team B takes ownership of the solution and Team A acts as an advisor. 

If, on the other hand, no one ends up caring about Team A’s fancy new build system, no harm done. Team A can run their solution in isolation and Team B doesn’t have to invest in generalizing it and supporting it company-wide. 

If another team wants to add yet another build system (this is actually most likely, sadly), we loop to pattern (a), above.

The advisor approach stands as an alternative to [Letting 1,000 Flowers Bloom](https://gigamonkeys.com/flowers/) , and hopefully eschews having to, "rip 999 [technologies] out by the roots," later on. Anyone who’s slogged through a multi-year migration knows how difficult it is to "rip out" even a single technology.

## No Team is Responsible for the Problem Space

In scenario (3), no team is responsible for the problem space. Problem space owners are normally vigilant and protective of teams encroaching on their domain. Without an owner, the most likely outcome is that teams will silently ship whatever they want. Consequently, the main problem when no owner exists is that of discovery: finding out that a new technology is being introduced.

Lack of domain ownership is most common at smaller or hyper-growth companies and startups. In my build system example, it’s unlikely that a startup has a team responsible for builds. Luckily, it’s easier to know what everyone is doing at small companies because everyone is usually sitting in the same area (or Slack channel), talking, and reviewing each other’s work (right?).

When WePay’s engineering team was only 19 people, no team owned service infrastructure. Developers built services in whatever they wanted. Critically, though, there were only 3 services. We had Spring, Play (and Scala), and Dropwizard services initially. It was easy enough to pick one and move forward. The two non-standard services floated around for a year or two, but they went away eventually.

Discovery is harder at large and fast-growing (chaotic) companies. It’s impossible for all teams to know what everyone else is doing, and poorly implemented processes can get in the way of developer velocity.

* Lean on your technical leads
* Have a design review process 
* Implement build and deployment controls.

A tight-knit group of good technical leads will discover new ownership and technology issues on their own (and often resolve them on their own, too). Make sure you have tech leads in place.

A semi-centralized design review process such as [WePay’s design review blog post](https://wecode.wepay.com/posts/effective-software-design-documents) also exposes ownership gaps and new technologies creeping into a company’s tech stack. Take a look at the [architectural decision records (ADR)](https://adr.github.io/) website, too.

Build and deployment controls prevent a single team from shipping new technology without telling anyone. The [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) (PoLP) can be used to limit what engineers can do on their own. Control policies should be automated and not get in the way as long as engineers "color within the lines". Only when an engineering team is trying to deviate from approved technology should they be impeded. Pre-approved Docker images, [Black Duck](https://www.blackducksoftware.com/) scans on 3rd party libraries, limited internet access on CI machines, git repository scans and monitoring, and restricted access to cloud control panels all prevent engineers from going too far off the rails.

## Notes

* Thanks to Gwen Shapira and Luca Palmieri for feedback on early drafts. Thanks to Sriram Subramanian for feedback and for clarifying my thoughts around discovery at large organizations.
* This post does not cover everything needed to add a new technology to an engineering organization. I’m focusing on discovery, ownership, and technology processes.
