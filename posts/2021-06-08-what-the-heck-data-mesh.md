---
blurb: I got sucked into a data mesh  Twitter thread  this weekend (it’s worth a read
  if you haven’t seen it). Data meshes have clearly struck a nerve. Some don’t understand
  them, while others believe ...
changelog:
- author: Chris Riccomini
  date: '2025-02-11T03:37:54+08:00'
  hash: d19b4fe21deb3d05c34bfd4c3bc577ce829929e5
  message: Fix redirects
- author: Chris Riccomini
  date: '2025-02-11T02:34:29+08:00'
  hash: e09bef81474c5cfb2159faeb6f5fa5a22d523737
  message: Migrate to markupdown (#1)
created_at: '2021-06-08T00:00:00Z'
link: /posts/2021-06-08-what-the-heck-data-mesh
redirects_from: /essays/what-the-heck-data-mesh
template: post
title: What the Heck is a Data Mesh?!
toc:
- level: 1
  slug: what-the-heck-is-a-data-mesh
  title: What the Heck is a Data Mesh?!
- level: 2
  slug: what-the-heck-is-a-data-mesh_data-as-a-product
  title: Data as a Product
- level: 2
  slug: what-the-heck-is-a-data-mesh_modern-service-stacks
  title: Modern Service Stacks
- level: 2
  slug: what-the-heck-is-a-data-mesh_infrastructure
  title: Infrastructure
- level: 2
  slug: what-the-heck-is-a-data-mesh_culture
  title: Culture
- level: 2
  slug: what-the-heck-is-a-data-mesh_pitfalls
  title: Pitfalls
- level: 2
  slug: what-the-heck-is-a-data-mesh_notes
  title: Notes
updated_at: '2025-02-11T03:37:54+08:00'
---

# What the Heck is a Data Mesh?!

I got sucked into a data mesh  [Twitter thread](https://twitter.com/fulhack/status/1400461693197570051)  this weekend (it’s worth a read if you haven’t seen it). Data meshes have clearly struck a nerve. Some don’t understand them, while others believe they’re a bad idea. Yet, "Demystifying Data Mesh" and "Putting Data Mesh to Work" articles abound.

To understand the confusion, I re-read  [Zhamak Dehghani](https://twitter.com/zhamakd) ’s  [original](https://martinfowler.com/articles/data-monolith-to-mesh.html)  and  [follow-on](https://martinfowler.com/articles/data-mesh-principles.html)  posts. Zhamak is the creator of the data mesh. In her second post she identifies  [four data mesh principles](https://martinfowler.com/articles/data-mesh-principles.html#CorePrinciplesAndLogicalArchitectureOfDataMesh):

1. Domain-oriented decentralized data ownership and architecture
2. Data as a product
3. Self-serve data infrastructure as a platform
4. Federated computational governance

I believe that putting these principles on equal footing creates confusion. The second principle—data as a product—is the motivating reason for a data mesh and worth considering on its own. Once we explore what "data as a product" is, we can discuss the implications: the need for decentralization, self-serve infrastructure, and federated governance.

## Data as a Product
Application data has customers just like any other product. Data scientists, business analysts, finance, sales operations, product managers, and engineers all use application data. Machine learning models, charts, graphs, reports, and even other web services are all built on top of application data. And application data is being increasingly exposed to paying customers as part of the "real" product (Stripe’s  [Sigma](https://stripe.com/sigma)  is an example).

Yet, organizations don’t think of data as a product. While development teams spend time documenting, versioning, refactoring, and curating web service data models and APIs, data goes largely ignored. Organizations with ETL pipelines either directly expose web service data models, or have a centralized team that builds a manicured data warehouse. Data models well suited for low-latency web services are difficult for humans to work with. A centralized data warehousing team simply hides the suffering behind a team of hapless data engineers left with the sisyphean task of interpreting internal schemas, chasing data as it’s migrated, building their own—often inaccurate—data models, and desperately propping up a monolithic data pipeline. It would be madness to propose centralizing all service API and data modeling, yet that’s what we’ve done with data.

What we need, instead, is for organizations to treat data with the same care that they treat any other public facing API. Data must have well-defined schemas, be versioned, enforce compatibility guarantees, be well documented, and so on. Basically, organizations need to act like their data is being used by humans, because it is!

But how do you build a data product? I’ve already said that centralized teams don’t do a good job of this; we’ve tried it for decades and it just doesn’t work well. Data products must be built in a decentralized manner by the teams that own the data; they’re the ones that understand it. Decentralization is where the other three principles come in, and that’s where I think a lot of the confusion lies. To demystify these principles, I’ll use the modern service stack for comparison.

## Modern Service Stacks
Modern service stacks have a few important characteristics:

a. Decentralized microservice API ownership and architecture
b. Self-serve service infrastructure as a platform
c. Federated service governance

These characteristics map to data mesh principles (1), (3), and (4).

It should surprise no one that a modern service stack is decentralized (a). Such stacks typically have hundreds or thousands of different services owned by dozens or hundreds of teams. Each team is left to define, build, and own its APIs.

Teams also deploy and monitor their own services (b). Self-deployment increases feature delivery velocity: developers aren’t stuck waiting on a separate team of button-pushers to deploy changes. And a centralized team isn’t left deploying software that they don’t understand (sound familiar?).

But application developers don’t always have the skills necessary to define well-factored APIs or troubleshoot complex deployment issues. Federated governance (c) through service infrastructure teams, DevOps culture, and embedded site reliability engineers (SREs) acts as a counter-weight to decentralization.

Centralized teams define standard serialization formats, service frameworks, and API modeling and compatibility rules. These "service infrastructure" or "service platform" teams write tools to enforce the standards and assist application developers in generating clean service scaffolding. And committee-style design reviews emerge to give application developers API modeling guidance.

Similarly, DevOps culture and embedded site reliability engineers (SREs) have emerged to help application developers deploy their changes reliably. DevOps provides guard rails through automated tooling, so developers can confidently deploy their services using blue/green deployments, canaries, dynamic pre-production environments, and A/B splits. Highly evolved DevOps organizations might even have monitoring with auto-rollback if error rate increases. In addition, site reliability engineers can be embedded on application development teams to assist with operational issues and tooling development.

A data mesh takes service stack best-practices and applies them to the data layer. Not only should application development teams define APIs for their business logic (in the form of web services); they should do so for their data as well. The infrastructure and culture needed for the two are remarkably similar.

## Infrastructure
Application teams need infrastructure to define their data product, to transform their internal data into the data product format, and to transfer the data product to its destination database(s). 

Data product schemas are defined using standard formats like Protocol buffers, Avro, or JSON schema. Schema metadata—versioning, ownership, lineage, comments, usage, and so on—are attached using data catalogs like [Amundsen](https://github.com/amundsen-io/amundsen), [Datahub](https://github.com/linkedin/datahub), and [Marquez](https://github.com/MarquezProject/marquez) (the space is booming). Compatibility rules are enforced using tools like [Confluent](https://www.confluent.io/)’s [schema registry](https://docs.confluent.io/platform/current/schema-registry/avro.html#schema-evolution-and-compatibility) or home-grown validators that are inserted into the CI/CD pipeline to run pre-commit checks.

Developers quickly find that the data products they wish to expose don’t match their internal database schemas (something their data engineers could have told them a decade ago). A data pipeline is needed to transfer and transform data into its user-facing format. 

Data pipelines aren’t new—it’s ETL—but the _who_ is new. Centralized teams aren’t responsible for the transfer and transformation, application developers are. A decentralized data platform must be built. Automated pipeline generation tools can be built on top of [Airflow](https://airflow.apache.org/), [Prefect](https://www.prefect.io/), and [dbt](https://www.getdbt.com/). Application engineers can define their data products and transformations, and tools can auto-generate their transformation workflows. 

If the data pipeline is stream-based, transfer and transformation are done through streaming systems and stream processors like [Kafka Streams](https://kafka.apache.org/0102/documentation/streams/), [Flink](https://flink.apache.org/), and so on. Tooling to auto-generate simple transformations from configuration needs to be built here, too. Best practices like the  [outbox pattern](https://debezium.io/blog/2019/02/19/reliable-microservices-data-exchange-with-the-outbox-pattern/)  are also emerging.

Deployment will need to be automated in the same fashion as service CI/CD pipelines. The same deployment and orchestration tooling that exists for microservices can be repurposed for distributed data pipelines.

GDPR and its offshoots are real. Sensitive data should not be exposed. Security and compliance have historically been enforced centrally through the data warehousing team. Now, we’ll need infrastructure and tooling to do this. Data catalogs can play a role here, as can automated detection tools like [Google Cloud’s DLP](https://cloud.google.com/dlp) solution. Access control (who gets access to what data) will need to be enforced through policy codified in configuration. 

There are of course other infrastructure requirements; the  [DataOps](https://datakitchen.io/what-is-dataops/)  movement covers a lot of them. I’m not being exhaustive here, the point is that many of the same infrastructure requirements exist for data mesh as exist for service stacks, and there are many tools to address them.

If you forced me to define the infrastructure for a minimum-viable data mesh, I’d say:

* **A schema definition tool**
  Protocol buffers, Avro, JSON schema
* **A transfer/transformation tool**
  Airflow, Prefect, Kafka Streams, Kafka Connect, Flink
* **A data warehousing tool**
  Snowflake, BigQuery
* **A data catalog**
  Amundsen, Datahub, Marquez

## Culture
Technology alone doesn’t make a data mesh. The shift to decentralized data pipelines and data warehouses requires cultural change within the organization. 

Just as application developers might not have all the skills to define well-factored service APIs, they probably won’t have the skills to define a well-factored data product or run a data pipeline. Again, the same problems exist for service oriented architectures (SOAs), and the same solutions can be applied. Data infrastructure teams, DataOps culture, and embedded data engineers help to bridge the skill gap and provide guard rails.

"Data infrastructure" or "data platform" teams need to be created to build the distributed data platform infrastructure—the stuff listed in the _infrastructure_ section above. Infrastructure teams must also build DataOps tooling to provide guard rails and instill DevOps best practices. Data quality checks and monitoring ([Anomalo](https://www.anomalo.com/)  and  [BigEye](https://www.bigeye.com/about/)), pipeline tests (both  [schema and data](https://docs.getdbt.com/docs/building-a-dbt-project/tests)), and standard service deployment practices are used. DataOps focuses heavily on Agile culture, and espouses lean manufacturing best practices and statistical process control (SPC); it's as much culture as tooling.

Centralized committees define standard serialization formats, transformation frameworks, and data modeling and compatibility rules. Design committees emerge to give application developers data modeling guidance for their data products. We had teams responsible for reviewing and providing guidance for both service APIs and data products nearly a decade ago at LinkedIn.

And just as SREs are embedded in application development teams, so too can data engineers be. Embedded data engineers are responsible for defining data products, maintaining data pipelines, and building data tooling within the team.

Above all, application teams need to buy into the idea that data is a product they need to invest in. This is a hard sell; it’s something that gets in the way of their "real" work. Finding champions within the org can help. And as user-facing data products like Stripe’s Sigma grow pervasive, application teams will be exposed to the pain data warehousing teams have been feeling. Engineers will begin demanding data products on their own; it will be intuitive to them—it’s the same stuff they’ve been doing with service oriented architectures and DevOps.

If you forced me to define the culture for a minimum-viable data mesh, I’d say:

* Application teams accept responsibility for building data products
* DevOps best practices are adopted for data products and data infrastructure
* Data product standards are well defined and programmatically enforced

## Pitfalls
As with a modern service stack, a data mesh is bound to have pitfalls. Lack of standards and REST pedants are a real problem.

Many service stacks begin with no clear set of standards. Teams build services using their own frameworks and tools, and don’t adhere to REST or gRPC best practices. What emerges is a distributed monolith with poorly documented APIs.

Work in software long enough, and you’ll eventually come across the abrasive REST obsessive. The person ranting about nouns, verbs, URNs, and the "right" way to do REST. Stuff like the  [Richardson Maturity Model](https://martinfowler.com/articles/richardsonMaturityModel.html)  (nothing against this, but some people get way too into it).

Agile ninjas and blackbelts emerge on the culture-side to dictate how to "do" Agile. Certifications are created and thick tomes of gobbledygook are written so vendors and consultants can make a buck.

All of these risks exist for data meshes, too. This doesn’t mean that the data mesh is a bad idea any more that it means service oriented architecture or Agile are bad ideas. They’re just tools and practices that can be used or misused, like any other. Start with data products and see where it takes you.

## Notes
* I use data warehouse, data mart, and data lake interchangeably here. Zhamak uses the term _data plane_.
* Thanks to Dmitriy Ryaboy, Gunnar Morling, Kishore Gopalakrishna, and Erik Bernhardsson.
* I use "modern service stack" and SOA interchangeably.
* I am not involved with the data mesh project in any way. I’m a fan of Zhamak’s work.
* I am investor in several companies related to this post (Prefect, Amundsen, Confluent, Stemma).