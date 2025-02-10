---
created_at: '2023-01-05T00:00:00Z'
redirects_from: /essays/recap-for-people-who-hate-data-catalogs
---

# Recap: A Data Catalog for People Who Hate Data Catalogs

I’m excited to release [Recap](https://github.com/recap-cloud/recap), a dead simple data catalog for engineers, written in Python. Recap makes it easy for engineers to build infrastructure and tools that need metadata. Unlike traditional data catalogs, Recap is designed to power software.

Recap is a data catalog for machines–a metadata service. It supports neither the same users nor use cases as traditional catalogs. Humans use traditional data catalogs. Machines and software use Recap. Traditional catalogs focus on data discovery and curation. Recap focuses on metadata that software needs–schema, access controls, data profiles, indexes, and queries. Recap could be part of a traditional data catalog, something you could use to build a data catalog, but it isn’t a data catalog.

Recap is something I always wanted at my last job. My data engineering team wrote a lot of scripts to automate new data pipeline creation, create data warehouse views, manage user access controls, detect sensitive information (PII), and locate data quality issues. Our work required metadata, which we scraped from BigQuery, MySQL, Airflow, and other systems in an ad-hoc way. Each scraping implementation was brittle and costly to maintain.

Such an experience is hardly unique. Data quality, data contract, data discovery, compliance, governance, and ETL tools all need metadata–row counts, cardinality, distribution, max, min, number of nulls, and so on. Even query engines use similar metadata for planning and optimization.

Developers have two ways to get at this metadata: collect metadata directly in their tools or fetch metadata from a data catalog, which does the scraping.

In-tool metadata collection–by far the most common–is inefficient and error prone. Different systems scan over the same data over and over again without coordination. Duplicate scans increase cloud costs and decrease upstream application performance. Developers must also implement each individual source’s metadata API and understand its nuances.

I haven’t found many examples of the second approach–fetching metadata from a data catalog. Catalogs cover dozens of use cases and are used by entire organizations. Such a wide surface area leads to a complex product and bloated operational footprint. We actually tried to get a catalog up and running at WePay; it did not go well.

Yet, for all the use cases catalogs cover, they still lack many of the features that engineers want: a decent CLI, a nice library, a small operational footprint, deep and robust data statistics, and a composable architecture. Engineers need these features because they’re using metadata to build software, not locate data. Recap addresses these needs.

Recap’s UI is a [CLI](https://docs.recap.cloud/latest/commands/) and [REST API](https://docs.recap.cloud/latest/server/). It runs with no web front-end, no scheduler, no orchestrator, and no external system dependencies. Recap can also be run as a Python library, so it’s easy to integrate with data engineering and analytics engineering tools. The REST service works with infrastructure in other languages and allows Recap to be run centrally. The code is modular and pluggable, so developers can extend it where needed.

Recap is a young project. It needs tests, for one thing. I want to add streaming ([Kafka](https://kafka.apache.org/)), file system ([S3](https://aws.amazon.com/s3/), [GCS](https://cloud.google.com/storage)), and data lake crawlers ([Iceberg](https://iceberg.apache.org/), [Hudi](https://hudi.apache.org/)). [Airflow](https://airflow.apache.org/), [Prefect](https://www.prefect.io/), and [Dagster](https://dagster.io/) integrations would be nice. And of course, more data analyzers to get more statistics. I’m open sourcing Recap now to solicit feedback and because I think Recap is already useful.

Star [Recap’s repository](https://github.com/recap-cloud/recap), then get started with [Recap’s documentation](https://docs.recap.cloud/). You can find me on Twitter [@criccomini](https://twitter.com/criccomini) and Mastodon [@criccomini@data-folks.masto.host](https://data-folks.masto.host/@criccomini). Let me know if you’re interested in integrating Recap with your software. I look forward to hearing from you!

*Thanks to Josh Wills, Jacob Matson, Ananth Packkildurai, Sarah Catanzaro, Chrix Finne, and Chad Sanderson for early draft feedback.*
