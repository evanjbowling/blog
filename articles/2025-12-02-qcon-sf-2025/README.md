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

#### Monday 2025-11-17T09:00 [From Friction to Flow: How Great DevEx Makes Everything Awesome](https://qconsf.com/keynote/nov2025/friction-flow-how-great-devex-makes-everything-awesome)

Keynote. Nicole Forsgren (author of [Accelerate](https://nicolefv.com/writing)) described how AI is revealing
friction that exists because code creation is speeding up but not necessarily shipping faster.

#### Monday 2025-11-17T10:35 [How to Build an Exchange: Sub Millisecond Response Times and 24/7 Uptimes in the Cloud](https://qconsf.com/presentation/nov2025/how-build-exchange)

Track: Architectures You've Always Wondered About

- Keep your core simple (not simple: concurrency and non-deterministic execution; simple: single-threaded execution)
- Achieved rolling deploys with sub second market impact
- API Gateway is fairly simple thing, rate limiting, should be stateless, ideally dumb and fast
- Control our egress costs by replicating "events" across regions instead of full state (which is much larger)
- Avoid blocking the hot path (careful when putting replicas in different AZs; 

#### Monday 2025-11-17T11:45 [Compiling Workflow into Databases: The Architecture That Shouldn't Work (But Does)](https://qconsf.com/presentation/nov2025/compiling-workflows-databases-architecture-shouldnt-work-does)

Track: Architectures You've Always Wondered About

#### Monday 2025-11-17T13:35 Maximising Success with Limited Time, Resources and Energy: Lessons from Startup Engineering

Track: Effective Engineering and Practices in Early Stage Startups

#### Monday 2025-11-17T14:45 Building Resilient Platforms: Insights from 20+ Years in Mission-Critical Infrastructure

Track: Architectures You've Always Wondered About

#### Monday 2025-11-17T15:55 Building Zero-CVE Container Images at Scale: Patterns and Pitfalls

Track: Sponsored Solution Track 1

#### Monday 2025-11-17T17:05 Directing a Swarm of Agents for Fun and Profit

Track: Polyglot Platforms: Strategies & Practices to Enable Innovation


