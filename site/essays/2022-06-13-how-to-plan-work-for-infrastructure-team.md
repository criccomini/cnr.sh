---
blurb: Building tooling and systems for other engineers at a company can be tough.
  Project planning, in particular, presents a challenge. Infrastructure teams have
  several unique traits that hinder ...
date: June 13, 2022
link: /essays/2022-06-13-how-to-plan-work-for-infrastructure-team
title: How to Plan Work for an Infrastructure Team
---

Building tooling and systems for other engineers at a company can be tough. Project planning, in particular, presents a challenge. Infrastructure teams have several unique traits that hinder predictable planning.

Infrastructure teams are less likely to have product managers to help with planning. Infrastructure engineering managers are left to do prioritization, requirements gathering, and quarterly/yearly planning on their own. Managers don't always know how to do this effectively.

Such teams also sit directly next to their customers (or at least they used to before the pandemic). Close proximity to the customer is a double edged sword. Teams are able to gather feedback rapidly and have close daily contact with their users (the other engineers in the company).

But infrastructure teams are so easy to access that they are interrupted frequently. Imagine if customers could walk directly up to an application engineer and demand a product change. Infrastructure engineers live this experience. Managing these interruptions is challenging.

Despite close customer contact, infrastructure teams are often disconnected from product planning itself. Other teams don't inform the infrastructure team that a new feature depends on the infrastructure teams until it's too late. Engineers are left scrambling and frustrated.

A few years ago, an infrastructure team at WePay was having trouble planning their work. The team was handling constant interrupts--both operational issues and urgent requests--from other teams. The manager threw up their hands and declared it impossible to reliably plan and deliver projects of their own; the team was purely reactive.

At the time, I was running WePay's data infrastructure team. I heard the manager's frustration, and shared some of the practices I'd found helpful in planning for my own team.

The rest of this post is the (edited) email that I sent the manager. Everything here can (and should) be adjusted, but the structure presented below is a reasonable starting point. If it resonates with you and you want more, I highly recommend [Will Larson](https://lethain.com/)'s book, [_An Elegant Puzzle_](https://www.amazon.com/dp/B07QYCHJ7V).

_Context: My data infrastructure team was about 6 people (including 2 site reliability engineers (SREs)). The company had roughly 300 people. We were using JIRA as our ticketing system and a loose Agile/Scrum planning methodology. We had 2-week sprints and both quarterly and yearly planning._

---

Going to share how I run data infrastructure (DI). Goal is to:
 
1. Clarify how DI runs. Mostly just FYI.
2. Give (the team manager) some thoughts on how he might get INFRA planning working properly.
 
I have iterated on this for about a year. I'm not done yet (never will be), but feel like we've hit a very good spot. My Q1 planned vs. executed was very good.

Some things I'm doing. Hope it's useful. Take it or leave it.

## Axioms

* Plan to 80% capacity, not 100%. See my epiphany  [here](https://twitter.com/criccomini/status/1242629436685475840).
* Fill out story point estimates for all non-support JIRAs. No exceptions. This is what lets you plan--looking backwards to see these numbers.

## Sprint Planning

* 1 point = a single 4 hour work day.
* Fibonacci numbers only (1, 2, 3, 5, 8, 13) for story point values. Should really never get beyond 8. Even then, 8 is high--we only use this for spikes, really.
* Most tickets are 3 or 5 points. Even when they seem like 1 or 2, they never are.
* Assign 8 points per-sprint per-person. Adjust periodically based on JIRA sprint reports--they tell you completion % and whatnot.
* On-call gets no tickets assigned for the sprint.

## Quarterly Planning

* Plan at 80% capacity. There, I said it again. You can adjust the %--maybe it's 70, or even 60 for you. Start with 80. This will let you absorb surprises.
* Formula for calculating capacity for your team here (_see the table at the end_). It includes subtracting a) on-call b) vacations c) 20% capacity.
* I have a "run the business" (RTB) epic. I leave the epic empty (or nearly so). I calculate sprints for it based on the prior quarter. (e.g. if I had 6 sprints of tickets done in Q1, then I allocate 6 for Q2).
* RTB epic is *NOT* on-call support. This is busted stuff that *your team finds* and wants to fix throughout the quarter. SOMETIMES an on-call request will result in such a discovery, but it's RARE. See example here (_link to internal JIRA_).
* I have a "Spikes for Q(n+1)" epic. This contains SPIKE JIRAs for any work that needs to be done next quarter. The expected output of these JIRAs is: a) a design doc b) JIRAs for all the work to be done in Q(n+1) sorted in execution order in the JIRA backlog. See example here (_link to internal doc_).

## Yearly Planning

* I plan 4-6 quarters ahead. See this sheet for what I'm doing here (_link to internal doc_).
* Obviously, I can't predict what others will ask of me. I know what I want to do, though. I act as the PM for the team. I decide priorities. People come to me, and ask for stuff. I work with them to understand what needs to be done, and decide when we're going to do it. Try to be pragmatic.
* I have divided work into projects. Projects span multiple quarters. Every quarter has one or more epics with a lead engineer assigned. In some cases, I add a secondary.

## On-call

* We have two on-calls: an SRE and a developer. This is a third of our team. You should consider having two SRE on calls since you're all SREs. This might be half your team. If this is what it takes, so be it. Don't lie to yourself (and everyone else), and then miss all your goals.
* SRE on-call handles operational issues.
* Developer on-call handles random developer questions, support, and bug reports. They're also available to help SRE with prod operational issues.
* All alerts must go through Pager Duty. No direct email alerts. No direct Slack alerts. No exceptions. Alerts escalate from SRE -> dev -> me (if they're important).
* We use our JIRA support email extensively (_an internal support email alias that auto-creates JIRA tickets when emailed_). This is where all support tasks (dev on call work) come from. We force people to use it. They do. Again, useful for tracking purposes. Be obsessive. Story points are not required for support tasks--there's such volume that we just do raw JIRA count as the metric.

One final note: I reject your premise that you can't estimate or plan for surprises. (_The engineering manager had this comment on Slack._) I have several devices to manage this:

a. 80% capacity
b. empty RTB at the start of each quarter
c. two people on-call
d. yearly planning
 
Cheers,\
Chris

P.S. Here's how I calculated the team's capacity this quarter.



| | |
| ----------- | ----------- |
| **Inputs:** | |
| Sprints in Q2      | 6       |
| Devs   | 4        |
| SREs   | 2        |
| Dev holiday (sprints) | 2 |
| Dev on-call (sprints) | 6 |
| SRE holiday (sprints) | 1 |
| SRE on-call (sprints) | 6 |
| **Calculation:** | |
| Dev capacity (sprints) | 16 = _4 devs * 6 sprints - 6 on-call sprints - 2 holiday sprints_ |
| SRE capacity (sprints) | 5 = _2 SREs * 6 sprints - 6 on-call sprints - 1 holiday sprint_ |
| 80% dev capacity | 12 = _16 dev sprints * .8_ |
| 80% SRE capacity | 4 = _5 SRE sprints * .8_ |
| **Final dev capacity** | 12 sprints |
| **Final SRE capacity** | 4 sprints |