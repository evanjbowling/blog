# QCon SF 2025

There were 12 tracks at QCon 2025. I hoped to learn about 3 key things:
architecture, leadership and AI. Here's my main takeaways:

## Architecture

- DBOS proposes an approach for writing workflow code (compare with temporal,
  airflow, argo workflows) directly within your existing application and using
  the DB you (likely) already have for task persistence and exactly once execution.

## Leadership

- Lessons from startups; choose tools that remove friction. Startups often get ~10
  major pushes or less, need to aim for most value with each push. Optimize for learning
  speed (how fast can you deploy and learn from user base).


## Appendix

### Personal Schedule and Notes

#### Monday

##### `09:00` [From Friction to Flow: How Great DevEx Makes Everything Awesome](https://qconsf.com/keynote/nov2025/friction-flow-how-great-devex-makes-everything-awesome)

Keynote.

Nicole Forsgren (author of [Accelerate](https://nicolefv.com/writing)) described how AI is revealing
friction that exists because code creation is speeding up but not necessarily shipping faster.

##### `10:35` [How to Build an Exchange: Sub Millisecond Response Times and 24/7 Uptimes in the Cloud](https://qconsf.com/presentation/nov2025/how-build-exchange)

Track: Architectures You've Always Wondered About

- Keep your core simple (not simple: concurrency and non-deterministic execution; simple: single-threaded execution)
- Achieved rolling deploys with sub second market impact
- API Gateway is fairly simple thing, rate limiting, should be stateless, ideally dumb and fast
- Control our egress costs by replicating "events" across regions instead of full state (which is much larger)
- Avoid blocking the hot path (careful when putting replicas in different AZs; 

##### `11:45` [Compiling Workflow into Databases: The Architecture That Shouldn't Work (But Does)](https://qconsf.com/presentation/nov2025/compiling-workflows-databases-architecture-shouldnt-work-does)

Track: Architectures You've Always Wondered About

##### `13:35` [Maximising Success with Limited Time, Resources and Energy: Lessons from Startup Engineering](https://qconsf.com/presentation/nov2025/maximizing-success-limited-time-resources-and-energy-lessons-startup)

Track: Effective Engineering and Practices in Early Stage Startups

##### `14:45` [Building Resilient Platforms: Insights from 20+ Years in Mission-Critical Infrastructure](https://qconsf.com/presentation/nov2025/building-resilient-platforms-insights-20-years-mission-critical-infrastructure)

Track: Architectures You've Always Wondered About

##### `15:55` [Building Zero-CVE Container Images at Scale: Patterns and Pitfalls](https://qconsf.com/presentation/nov2025/building-zero-cve-container-images-scale-patterns-and-pitfalls)

Track: Sponsored Solution Track 1

##### `17:05` [Directing a Swarm of Agents for Fun and Profit](https://qconsf.com/presentation/nov2025/directing-swarm-agents-fun-and-profit)

Track: Polyglot Platforms: Strategies & Practices to Enable Innovation

#### Tuesday

##### `09:00` [Hidden Decisions You Don’t Know You’re Making](https://qconsf.com/keynote/nov2025/hidden-decisions-you-dont-know-youre-making)

Keynote.

##### `10:35` [Engineering at AI Speed: Lessons from the First Agentically Accelerated Software Project](https://qconsf.com/presentation/nov2025/engineering-ai-speed-lessons-first-agentically-accelerated-software-project)

Track: AI Engineering that Delivers: Blueprint to Impact

##### `11:45` [Panel: The Path to Senior Engineering Leadership](https://qconsf.com/presentation/nov2025/panel-path-senior-engineering-leadership)

Track: The Path to Senior Engineering Leadership

##### `13:35` [Building Agentic Workflows with MCP (AI Engineering that Delivers)](https://qconsf.com/presentation/nov2025/building-agentic-workflows-mcp-ai-engineering-delivers)

Track: Sponsored Solution Track II

##### `14:45` [Stripe’s Docdb: How Zero-Downtime Data Movement Powers Trillion-Dollar Payment Processing](https://qconsf.com/presentation/nov2025/stripes-docdb-how-zero-downtime-data-movement-powers-trillion-dollar-payment)

Track: Navigating Major Architecture Migrations

##### `15:55` [Turning Outward: Growing From Code to Influence](https://qconsf.com/presentation/nov2025/turning-outward-growing-code-influence)

Track: The Path to Senior Engineering Leadership

##### `17:05` [Automating the Web With MCP: Infra That Doesn’t Break](https://qconsf.com/presentation/nov2025/automating-web-mcp-infra-doesnt-break)

Track: AI Engineering that Delivers: Blueprint to Impact

#### Wednesday

##### `09:00` [Open Source, Community, and Consequence: The Story of MongoDB](https://qconsf.com/keynote/nov2025/open-source-community-and-consequence-story-mongodb)

Keynote.

##### `10:35` [Choosing Your AI Copilot: Maximizing Developer Productivity](https://qconsf.com/presentation/nov2025/choosing-your-ai-copilot-maximizing-developer-productivity)

Track: Empowering Teams with AI: Productivity and the Future of Software Development

##### `11:45` [Accelerating LLM-Driven Developer Productivity at Zoox](https://qconsf.com/presentation/nov2025/accelerating-llm-driven-developer-productivity-zoox)

Track: Empowering Teams with AI: Productivity and the Future of Software Development

##### `13:35` [When Every Bit Counts: How Valkey Rebuilt Its Hashtable for Modern Hardware](https://qconsf.com/presentation/nov2025/when-every-bit-counts-how-valkey-rebuilt-its-hashtable-modern-hardware)

Track: High-Performance Languages in Modern Development

##### `14:45` [Week-Long Outage: Lifelong Lessons](https://qconsf.com/presentation/nov2025/week-long-outage-lifelong-lessons)

Track: The Stories Behind the Incidents

##### `15:55` [Trustworthy Productivity: Securing AI-Accelerated Development](https://qconsf.com/presentation/nov2025/trustworthy-productivity-securing-ai-accelerated-development)

Track: Empowering Teams with AI: Productivity and the Future of Software Development

##### `17:15` [Humans in the Loop: Engineering Leadership in a Chaotic Industry](https://qconsf.com/keynote/nov2025/humans-loop-engineering-leadership-chaotic-industry)

Keynote.


