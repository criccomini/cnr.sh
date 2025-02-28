---
backreferences:
- posts/2019-07-29-future-data-engineering.md
blurb: I've become much more comfortable with the idea of vendor lock-in. Or rather,
  I don't feel as locked in as I used to. The odd thing is, I'm using more proprietary
  systems than I ever have before ...
changelog:
- author: Chris Riccomini
  date: '2025-02-11T03:37:54+08:00'
  hash: d19b4fe21deb3d05c34bfd4c3bc577ce829929e5
  message: Fix redirects
- author: Chris Riccomini
  date: '2025-02-11T02:34:29+08:00'
  hash: e09bef81474c5cfb2159faeb6f5fa5a22d523737
  message: Migrate to markupdown (#1)
created_at: '2019-01-22T00:00:00Z'
link: /posts/2019-01-22-kafka-escape-hatch
redirects_from: /essays/kafka-escape-hatch
template: post
title: Kafka is your escape hatch
toc:
- level: 1
  slug: kafka-is-your-escape-hatch
  title: Kafka is your escape hatch
updated_at: '2025-02-11T03:37:54+08:00'
---

# Kafka is your escape hatch

I've become much more comfortable with the idea of vendor lock-in. Or rather, I don't feel as locked in as I used to. The odd thing is, I'm using more proprietary systems than I ever have before (thanks to the cloud). Apache Kafka is what's making me comfortable. Specifically, Kafka connect.

Historically, queuing and log data have flowed through Kafka, but primary data (often the most important stuff) has been more difficult to get into the system. Now that Kafka connect is gaining traction, and thanks to change data capture (CDC) connectors like Debezium, I'm starting to see glimpses of the promised future: all of an organization's data available in realtime to any piece of infrastructure that needs it. Once the data is in Kafka, it's so much more portable. This is a really big deal.

But why care about data portability? Most data processing involves two things: compute and storage. In Hadoop, for example, the compute layer is Map/Reduce, and the storage layer is HDFS. With data processing, what you're interested in is the compute part. The storage is just along for the ride; an optimized layer to allow the computation to take place quickly. But almost every time you add a new technology to provide some new style of computation (graph traversal, time series, map/reduce, SQL, key-value, streaming, geographic, ML), you have to integrate a new storage layer first. Kafka and Kafka connect make this much, much easier.

Now, if you decide you need to add search infrastructure to the mix in order to handle a search workload, you don't need to spin up a full ETL pipeline. Just install an Elastic search sink into your connect cluster, and off you go. Same deal for Druid if you need realtime analytics. Pick your data ware house of choice. The list goes on. It's getting really easy to use the right tool for the job. The data barrier is being broken down.

Portable data means you don't need to worry about vendor lock-in, either. It is becoming untenable for any serious piece of infrastructure not to integrate with Kafka. If the compute functionality warrants paying, by all means, use the proprietary system, but you don't need to worry about getting your data into (or out of) the system. Kafka is the tool that lets you sleep at night knowing that you can always move off of your infrastructure if something better (or cheaper) comes along.

The most important place where I see this popping up is an organization's ability to embrace the cloud. Once you have all your data in Kafka, it's getting more straight forward to integrate with proprietary cloud systems, whether it be proprietary data ware houses, RDBMs, key-value stores, stream processing system, or whatever else. And if you want a hybrid solution, Kafka helps there, too. The idea of running in AWS with Lambda, Aurora, and EC2, but using Google cloud's BigQuery solution as your data warehouse is not only possible, but reasonable.

Put another way, Kafka provides infrastructure agility. Data portability makes it easier to undo a mistake, change course if something isn't working out, or embrace new technology. Wrong infrastructure? Wrong vendor? Wrong cloud? Kafka and Kafka connect are helping to make these problems a thing of the past.