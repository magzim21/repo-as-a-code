locals {
  repo_readmes = {
    "ims-lp" = <<-EOT
# IMS Landing Page

## Mission
- Build a marketing landing page with above-the-fold performance, dynamic metadata, and localization-ready sections.
- Showcase responsive design tokens synced from Figma for typography, spacing, and color ramps.

## Implementation Checklist
1. Generate page copy blocks from structured JSON derived from design tokens.
2. Wire Open Graph, Twitter, and JSON-LD metadata to support multilingual variants.
3. Implement component-level pagination for testimonials, ensuring keyboard and screen-reader support.
4. Add localized CTA tracking with Datadog RUM attributes per language.

## Telemetry & QA
- Add Lighthouse CI to enforce performance and SEO thresholds.
- Snapshot test hero, features, and pricing sections across breakpoints.

## Deliverables
- Document translation workflow, token sync commands, and deployment checklist.
- Publish metrics dashboard link for Core Web Vitals monitoring.
EOT

    "codefast-day-01-next-api-gallery" = <<-EOT
# Codefast Day 01 · Next API Gallery

## Mission
- Render a grid of API-sourced cards with static generation, typed data validation, and accessible presentation.
- Demonstrate error-resilient fetching for third-party APIs and graceful empty/loading states.

## Implementation Checklist
1. Define a typed API client in `lib/api/gallery.ts` using Zod to guard the upstream contract.
2. Use `generateStaticParams` or `revalidate` to prebuild the gallery and refresh data hourly without deploys.
3. Compose a responsive card grid with Tailwind, focus-visible outlines, and semantic headings.
4. Persist the most recent payload in IndexedDB for instant back/forward navigation and offline fallback.

## Telemetry & QA
- Emit Datadog RUM custom actions for filter/pagination interactions and surface fetch latencies.
- Cover the data client with unit tests that stub the remote API, plus visual regression tests for the gallery states.

## Deliverables
- `README.md` documenting setup, environment variables, and architectural choices.
- ADR summarizing API selection trade-offs and caching strategy.
EOT

    "codefast-day-02-next-landing-page" = <<-EOT
# Codefast Day 02 · Next Landing Page

## Mission
- Build a marketing page with above-the-fold performance, dynamic metadata, and localization-ready sections.
- Showcase responsive design tokens synced from Figma for typography, spacing, and color ramps.

## Implementation Checklist
1. Generate page copy blocks from structured JSON derived from design tokens.
2. Wire Open Graph, Twitter, and JSON-LD metadata to support multilingual variants.
3. Implement component-level pagination for testimonials, ensuring keyboard and screen-reader support.
4. Add localized CTA tracking with Datadog RUM attributes per language.

## Telemetry & QA
- Add Lighthouse CI to enforce performance and SEO thresholds.
- Snapshot test hero, features, and pricing sections across breakpoints.

## Deliverables
- Document translation workflow, token sync commands, and deployment checklist.
- Publish metrics dashboard link for Core Web Vitals monitoring.
EOT

    "codefast-day-03-next-mdx-blog" = <<-EOT
# Codefast Day 03 · Next MDX Blog

## Mission
- Deliver an MDX-powered blog with pagination, tag filters, and API-driven author metadata.
- Keep design tokens in sync with Figma sources and surface version drifts in CI.

## Implementation Checklist
1. Configure `contentlayer` or `next-mdx-remote` with frontmatter validation and remark plugins.
2. Create API routes that hydrate author bios, social links, and badges from external services.
3. Implement infinite pagination using `useInfiniteQuery` backed by an IndexedDB cache for offline browsing.
4. Localize dates, slugs, and summaries, testing fallbacks for unsupported locales.

## Telemetry & QA
- Instrument Datadog RUM for scroll depth, tag clicks, and MDX render errors.
- Write unit tests for MDX components plus E2E coverage for pagination, search, and localization toggles.

## Deliverables
- README with content authoring workflow, linting commands, and publishing checklist.
- ADR covering decision to store content locally vs remote CMS.
EOT

    "codefast-day-04-next-pagination-lab" = <<-EOT
# Codefast Day 04 · Next Pagination Lab

## Mission
- Explore cursor-based pagination strategies across API, UI, and storage layers.
- Provide resilient fallbacks, skeleton states, and `API Error Boundary` coverage for degraded scenarios.

## Implementation Checklist
1. Create an abstraction for cursor-based fetches that supports retry, exponential backoff, and cancellation.
2. Render paginated results with optimistic prefetching and skeleton placeholders informed by design tokens.
3. Cache the last two pages in IndexedDB and sync when connectivity resumes.
4. Implement an error boundary dedicated to API failures with localized messaging and recovery CTA.

## Telemetry & QA
- Emit Datadog RUM custom timings for pagination latency and failure counts.
- Add unit tests for pagination hooks and integration tests for offline revalidation flows.

## Deliverables
- README describing pagination strategies, storage schema, and observability wiring.
- Checklist for extending the pattern to additional datasets.
EOT

    "codefast-day-05-next-seo-playbook" = <<-EOT
# Codefast Day 05 · Next SEO Playbook

## Mission
- Automate SEO audits using Lighthouse, sitemap generation, and hreflang coverage for multi-locale sites.
- Provide a repeatable workflow for running audits locally, in CI, and via scheduled jobs.

## Implementation Checklist
1. Build a sitemap + alternate locale indexer that respects canonical logic and dynamic routes.
2. Automate Lighthouse runs across top URLs, storing JSON results and thresholds in repo.
3. Generate per-route SEO reports with detected regressions and actionable checklist.
4. Integrate Datadog RUM Web Vitals with SEO audit outputs to correlate performance and search ranking.

## Telemetry & QA
- Send Lighthouse and Core Web Vital summaries to Datadog dashboards.
- Validate structured data with schema.org testing utilities, adding unit tests for metadata builders.

## Deliverables
- README detailing audit commands, schedule suggestions, and interpreting results.
- Template issue for SEO regressions with pre-filled reproduction steps.
EOT

    "codefast-day-06-seo-ab-testing" = <<-EOT
# Codefast Day 06 · SEO A/B Testing

## Mission
- Run server-side SEO experiments with variant metadata, canonical validation, and anomaly detection.
- Provide a governance model for launching, monitoring, and sunsetting experiments safely.

## Implementation Checklist
1. Create experiment config using JSON files synced from Figma tokens for typography and spacing variants.
2. Render metadata variants server-side with deterministic hashing to maintain consistent canonical links.
3. Track experiment cohorts, store results in Supabase or Planetscale, and surface dashboards in Datadog.
4. Automate regression checks for sitemap, robots, and hreflang compatibility per variant.

## Telemetry & QA
- Instrument RUM to include experiment bucket and measure CTR, bounce, and vital deltas.
- Write integration tests ensuring canonical URLs never diverge and experiments auto-expire.

## Deliverables
- README describing experiment lifecycle, governance checklist, and rollback guide.
- Example playbook for launching first SEO test with acceptance criteria.
EOT

    "codefast-day-07-figma-token-sync" = <<-EOT
# Codefast Day 07 · Figma Token Sync

## Mission
- Synchronize design tokens from Figma into JSON, Style Dictionary, and Tailwind layers on every push.
- Detect breaking token changes, notify relevant teams, and keep documentation current.

## Implementation Checklist
1. Configure token export pipeline using Figma REST API or Tokens Studio.
2. Normalize tokens into Style Dictionary categories and generate Tailwind config artifacts.
3. Publish tokens to npm or internal CDN, versioned and annotated with commit metadata.
4. Add drift detection comparing production CSS variables to latest token set.

## Telemetry & QA
- Emit Datadog RUM events when token changes propagate to runtime UI.
- Add unit tests for token transforms and schema validation for incoming payloads.

## Deliverables
- README covering setup, environment variables, and release workflow.
- Change log template for communicating visual diffs to stakeholders.
EOT

    "codefast-day-08-design-token-ci" = <<-EOT
# Codefast Day 08 · Design Token CI

## Mission
- Build a continuous integration pipeline to validate Figma-synced tokens against production CSS.
- Surface diffs, highlight accessibility regressions, and block merges on breaking changes.

## Implementation Checklist
1. Parse token JSON and compare against generated CSS variables from latest build artifacts.
2. Fail CI when tokens remove contrast-safe colors or introduce mismatched typography scale.
3. Generate visual diff artifacts using Playwright screenshots across key components.
4. Publish a Markdown summary to PR comments, linking to hosted previews via shad CDN.

## Telemetry & QA
- Track pipeline runtimes, failures, and severity tags in Datadog.
- Unit test diffing utilities and snapshot test generated markdown summaries.

## Deliverables
- README documenting CI stages, required secrets, and troubleshooting steps.
- Incident response guide for token regressions.
EOT

    "codefast-day-09-datadog-rum-instrumentation" = <<-EOT
# Codefast Day 09 · Datadog RUM Instrumentation

## Mission
- Instrument a Next.js app with Datadog RUM, user journey tagging, and session replay coverage.
- Standardize telemetry naming, sampling, and privacy controls.

## Implementation Checklist
1. Configure Datadog RUM SDK with service, version, and session sampling tuned per environment.
2. Add custom actions for key flows (pagination, uploads, localization) and attach user traits.
3. Mask PII fields, configure privacy rules, and document consent requirements.
4. Export dashboards summarizing Core Web Vitals, API errors, and user frustration signals.

## Telemetry & QA
- Validate instrumentation in lower environments before rolling to production.
- Add automated checks ensuring init script and environment variables are present in deploys.

## Deliverables
- README with instrumentation steps, dashboard links, and maintenance cadence.
- Runbook for triaging RUM alerts and correlating with backend traces.
EOT

    "codefast-day-10-rum-alerting" = <<-EOT
# Codefast Day 10 · RUM Alerting

## Mission
- Analyze Datadog RUM signals to detect Core Web Vital regressions and push actionable alerts to Slack.
- Provide runbooks and escalation paths for performance incidents.

## Implementation Checklist
1. Build queries correlating LCP, CLS, and FID with affected browsers, geos, and locales.
2. Configure composite alerts with suppression windows to avoid noisy notifications.
3. Stream alerts to Slack/Teams with context links, sample sessions, and resolution checklist.
4. Document on-call workflow, severity thresholds, and success metrics.

## Telemetry & QA
- Simulate degraded performance locally and ensure alerts fire with expected payloads.
- Unit test alert payload formatter and Slack webhook integration.

## Deliverables
- README detailing dashboard setup, alert tuning knobs, and escalation policy.
- Monthly review template for analyzing performance regressions.
EOT

    "codefast-day-11-notion-sync" = <<-EOT
# Codefast Day 11 · Notion Sync CLI

## Mission
- Mirror Notion content into Markdown, committing to GitHub with deterministic IDs and localization support.
- Enable scheduling, dry runs, and diff previews for editors.

## Implementation Checklist
1. Authenticate via Notion integration token and fetch pages with incremental sync timestamps.
2. Convert rich text blocks into MDX, preserving code blocks, callouts, and embedded media manifests.
3. Store previous sync state in local cache; resume gracefully after failures.
4. Add CLI commands for sync, diff, and publish, with optional Slack notifications.

## Telemetry & QA
- Emit metrics for synced pages, duration, and error counts to Datadog via statsd.
- Unit test block converters and integration test sync against fixture workspaces.

## Deliverables
- README explaining setup, environment variables, and Cron/CI usage.
- ADR detailing storage format decisions and conflict resolution strategy.
EOT

    "codefast-day-12-lesson-scheduler" = <<-EOT
# Codefast Day 12 · Lesson Scheduler

## Mission
- Sync Codefa.st modules with Google Calendar, handling timezone conversions and reminders.
- Keep schedules resilient to API quotas and offline edits, syncing once reconnected.

## Implementation Checklist
1. Model lessons with recurrence rules and metadata stored locally with Zod validation.
2. Integrate Google Calendar API using service account credentials and incremental sync tokens.
3. Provide UI for bulk adjustments with undo/redo, writing to IndexedDB when offline.
4. Send summary emails via Resend with localized agenda and links to resources.

## Telemetry & QA
- Instrument Datadog RUM for scheduling interactions and API error boundaries.
- Unit test recurrence logic and add integration tests for sync conflict resolution.

## Deliverables
- README covering Google Cloud setup, sync flows, and failure recovery tactics.
- Calendar governance checklist for course managers.
EOT

    "codefast-day-13-multi-api-atlas" = <<-EOT
# Codefast Day 13 · Multi-API Atlas

## Mission
- Centralize multiple APIs into a single dashboard with geospatial map overlays and localization toggles.
- Provide pagination, rate-limit protection, and offline caching for critical datasets.

## Implementation Checklist
1. Create data adapters per API with retry/backoff, response normalization, and schema validation.
2. Render a map interface overlaying API metrics; use design tokens for consistent markers and theming.
3. Implement dashboard pagination and filters, persisting user preferences in IndexedDB.
4. Localize UI strings, number/date formats, and API error boundary messaging.

## Telemetry & QA
- Emit Datadog RUM interactions for map usage, filter changes, and API failures.
- Add contract tests using mocked APIs plus E2E coverage for localization switching.

## Deliverables
- README detailing API onboarding checklist, caching strategy, and map integration steps.
- Runbook for rotating API credentials and handling degraded upstreams.
EOT

    "codefast-day-14-aceternity-theme-lab" = <<-EOT
# Codefast Day 14 · Aceternity Theme Lab

## Mission
- Rebuild `ui.aceternity.com` theme controls with live previews, design token mapping, and publish flow.
- Allow designers to tweak tokens, export configurations, and view contrast checks.

## Implementation Checklist
1. Sync Figma tokens and map them to Radix primitives powering Aceternity components.
2. Build live preview playground using shad UI, supporting light/dark/hi-contrast modes.
3. Persist custom themes in IndexedDB; offer export to JSON and shareable URLs.
4. Run automated contrast and accessibility audits per token change.

## Telemetry & QA
- Track theme edits, exports, and accessibility warnings in Datadog dashboards.
- Write unit tests for token mappers and integration tests for preview rendering.

## Deliverables
- README outlining token pipelines, preview architecture, and publishing workflow.
- Designer onboarding guide with step-by-step walkthrough.
EOT

    "codefast-day-15-offline-sync-queue" = <<-EOT
# Codefast Day 15 · Offline Sync Queue

## Mission
- Persist fetched data, uploads, and outbound emails in IndexedDB, syncing once the user is online.
- Guarantee idempotent processing, conflict resolution, and user visibility into sync status.

## Implementation Checklist
1. Build an offline queue abstraction storing tasks with metadata, retries, and dependency graph.
2. Capture file uploads via File System Access API, chunk uploads, and reconcile to REST endpoints when online.
3. Compose transactional email payloads and replay via Resend/Sendgrid upon reconnection.
4. Surface sync panels with progress indicators, error boundaries, and manual retry controls.

## Telemetry & QA
- Emit Datadog RUM events for queue size, sync duration, and failure types.
- Unit test queue state machine and integration test offline-to-online transitions with Playwright.

## Deliverables
- README describing offline architecture, storage schema, and sync lifecycle.
- Runbook for debugging stuck jobs and replaying failures.
EOT

    "codefast-day-16-component-token-diff" = <<-EOT
# Codefast Day 16 · Component Token Diff

## Mission
- Detect design token changes and surface their impact across Shadcn component stories.
- Provide visual diffs, regression alerts, and automated PR comments.

## Implementation Checklist
1. Snapshot tokens per branch and compute semantic diffs with color/typography awareness.
2. Generate Storybook stories per component variant, rendering before/after previews via Playwright.
3. Publish diff bundles to shad CDN with versioned URLs for review.
4. Comment on GitHub PRs summarizing risky changes and linking to visual diffs.

## Telemetry & QA
- Track diff runtime, changed components, and severity metrics in Datadog.
- Unit test diff classification and ensure CI fails on high-severity regressions.

## Deliverables
- README covering setup, required tokens, and diff interpretation guidelines.
- Contributor handbook for authoring new component stories.
EOT

    "codefast-day-17-rum-seo-correlation" = <<-EOT
# Codefast Day 17 · RUM + SEO Correlation

## Mission
- Correlate Datadog RUM metrics with SEO rankings to identify UX-driven search regressions.
- Provide dashboards, anomaly detection, and weekly reporting automation.

## Implementation Checklist
1. Ingest SEO rank data (e.g., GSC exports) and join with RUM metrics keyed by URL.
2. Build correlation models highlighting pages with performance or UX drops tied to rank loss.
3. Produce dashboards and scheduled reports stored in Git for governance.
4. Suggest remediation actions and track follow-through via issue templates.

## Telemetry & QA
- Validate data joins with unit tests and backfill pipelines with integration tests.
- Alert when correlation pipelines stop receiving fresh data or diverge unexpectedly.

## Deliverables
- README detailing data sources, pipeline schedule, and dashboard usage.
- Template for weekly experience-quality review meetings.
EOT

    "codefast-day-18-certificate-generator" = <<-EOT
# Codefast Day 18 · Certificate Generator

## Mission
- Generate personalized course completion certificates via PDFKit and edge functions.
- Support localization, custom branding, and secure share links.

## Implementation Checklist
1. Design certificate layout from Figma tokens and convert to PDFKit drawing commands.
2. Deploy edge function to generate PDFs on demand, caching signed URLs in Supabase.
3. Provide management UI for manual issuance, revocation, and re-send emails.
4. Log issuance events, attach RUM telemetry for download success/failure, and sync to CRM.

## Telemetry & QA
- Validate PDF rendering with snapshot tests and compare to golden images.
- Monitor generation latency and error rates in Datadog.

## Deliverables
- README documenting environment setup, branding overrides, and distribution workflow.
- Checklist for verifying new certificate designs.
EOT

    "codefast-day-19-shad-cdn-publisher" = <<-EOT
# Codefast Day 19 · Shad CDN Publisher

## Mission
- Publish Shadcn component bundles to a CDN with versioned exports, integrity metadata, and documentation.
- Provide automated release notes and compatibility matrices.

## Implementation Checklist
1. Bundle components with tsup/rolldown preserving tree-shakable modules.
2. Generate integrity hashes, changelog entries, and usage snippets per release.
3. Push artifacts to CDN storage (R2/S3) and update index manifests consumed by clients.
4. Provide CLI for consumers to pin versions, verify integrity, and bootstrap tokens.

## Telemetry & QA
- Track download metrics, cache hits, and release adoption in Datadog.
- Unit test bundling scripts and run contract tests against consumer fixtures.

## Deliverables
- README detailing release workflow, versioning policy, and rollback plan.
- Release checklist with verification steps and smoke tests.
EOT

    "codefast-day-20-shad-cdn-auditor" = <<-EOT
# Codefast Day 20 · Shad CDN Auditor

## Mission
- Audit shad CDN usage across repos, recommending accessible variants and tree-shaking improvements.
- Automate reports, remediation issues, and dependency updates.

## Implementation Checklist
1. Scan repositories for component imports, comparing against recommended usage guidelines.
2. Flag accessibility concerns (e.g., missing aria props) and propose shad alternatives.
3. Generate dependency update PRs via GitHub Actions with readme updates.
4. Publish aggregated reports to Datadog dashboards and send email summaries.

## Telemetry & QA
- Track audit coverage, issue counts, and remediation rate.
- Unit test static analysis rules and integration test GitHub automation flows.

## Deliverables
- README covering audit configuration, scheduling, and report interpretation.
- Governance model for rolling out fixes across teams.
EOT

    "codefast-day-21-quality-guardrails" = <<-EOT
# Codefast Day 21 · Quality Guardrails

## Mission
- Enforce API error boundaries, synthetic probes, and unit-tested handlers using file-based fixtures.
- Provide shared guardrails for pagination, file uploads, and localization flows.

## Implementation Checklist
1. Implement middleware wrapping fetch calls with standardized error responses and retries.
2. Create synthetic probes hitting key APIs via GitHub Actions on schedule, exporting metrics to Datadog.
3. Maintain fixture catalog for happy/error paths and reuse across unit/integration tests.
4. Surface guardrail status in dashboard with pass/fail indicators and incident history.

## Telemetry & QA
- Log boundary hits and recoveries in Datadog with severity tags.
- Ensure 90% coverage of handlers via tests, focusing on offline and throttled scenarios.

## Deliverables
- README describing guardrail patterns, probe configuration, and onboarding steps.
- Incident response guide for boundary violations.
EOT

    "codefast-day-22-kanban" = <<-EOT
# Codefast Day 22 · Kanban Planner

## Mission
- Deliver a drag-and-drop Kanban planner with optimistic updates, server actions, and offline support.

## Implementation Checklist
1. Model boards, columns, and cards with Prisma or Planetscale schema, expose typed API routes.
2. Implement drag-and-drop interactions using accessible libraries and keyboard shortcuts.
3. Cache board state locally; reconcile mutations when connectivity returns.
4. Integrate Datadog RUM to track interaction latency and error boundaries.

## Telemetry & QA
- Add integration tests for optimistic updates and conflict resolution.
- Monitor mutation success rates and session replay for drag interactions.

## Deliverables
- README with schema diagram, API contract, and deployment guide.
- Checklist for introducing new board automations.
EOT

    "codefast-day-23-search" = <<-EOT
# Codefast Day 23 · Knowledge Base Search

## Mission
- Ship an Algolia-powered search experience with instant faceting, pagination, and localization.

## Implementation Checklist
1. Define indexing pipeline, transform Markdown to searchable records with synonyms and locales.
2. Build searchable UI with query suggestions, recent searches, and offline caching of last results.
3. Add analytics tagging to correlate queries with RUM performance metrics.
4. Provide admin dashboard for managing synonyms and synonyms from Figma token names.

## Telemetry & QA
- Track search latency, zero-result queries, and conversion metrics in Datadog.
- Unit test transformers and add Cypress tests for filtering scenarios.

## Deliverables
- README detailing index configuration, deployment, and monitoring hooks.
- Troubleshooting guide for stale indices and API limits.
EOT

    "codefast-day-24-cohort-metrics" = <<-EOT
# Codefast Day 24 · Cohort Metrics

## Mission
- Compute SaaS cohort and retention metrics with SQL models, charts, and narrative insights.

## Implementation Checklist
1. Model cohorts in dbt or SQLMesh, version controlling transformations.
2. Build dashboards that visualize retention, reactivation, and churn by segment.
3. Storytell insights within README and scheduled email reports.
4. Connect RUM data to highlight UX shifts impacting retention.

## Telemetry & QA
- Validate SQL models with unit tests and data freshness checks.
- Alert when data pipelines lag or produce outliers.

## Deliverables
- README explaining metrics definitions, sources, and how to run transforms locally.
- Post-analysis template for sharing insights with stakeholders.
EOT

    "codefast-day-25-reminder-pwa" = <<-EOT
# Codefast Day 25 · Reminder PWA

## Mission
- Launch a mobile-first PWA for practice reminders with push notifications, offline support, and localization.

## Implementation Checklist
1. Configure service worker with pre-cache, runtime cache, and background sync for pending actions.
2. Offer scheduling UI with recurring reminders stored locally and synced to backend when connected.
3. Implement Web Push using VAPID keys, capturing delivery metrics in Datadog.
4. Localize reminder content, times, and units, respecting device locale.

## Telemetry & QA
- Measure install rate, offline usage, and push opt-in via RUM events.
- Add E2E tests for push registration, offline flows, and localization variations.

## Deliverables
- README covering PWA manifest, deployment checklist, and notification policies.
- Support playbook for troubleshooting push delivery issues.
EOT

    "codefast-day-26-seo-rum-dashboard" = <<-EOT
# Codefast Day 26 · SEO + RUM Dashboard

## Mission
- Ship a unified dashboard combining SEO metrics and Datadog RUM insights with anomaly detection.

## Implementation Checklist
1. Ingest rank, crawl, and Lighthouse data alongside RUM telemetry.
2. Build visualizations that correlate UX regressions with search performance.
3. Implement anomaly detection and alert routing with severity labels.
4. Generate executive summary PDFs weekly and email to stakeholders.

## Telemetry & QA
- Validate data refresh jobs, heartbeat monitors, and chart rendering in CI.
- Unit test data transforms and guard against missing metrics.

## Deliverables
- README detailing data connectors, dashboard usage, and alert governance.
- Template for weekly executive summaries with required talking points.
EOT

    "codefast-day-27-figma-token-cli" = <<-EOT
# Codefast Day 27 · Figma Token CLI

## Mission
- Provide a CLI for syncing Figma tokens across repos, emitting change logs, and GitHub check outputs.

## Implementation Checklist
1. Support commands for pull, diff, publish, and validate operations with configuration file.
2. Output Markdown changelog summarizing token updates, breaking changes, and impacted components.
3. Integrate with GitHub Checks API, annotating PRs with token diffs.
4. Cache responses locally to respect Figma rate limits and support offline simulation.

## Telemetry & QA
- Track command runtimes and failure rates via Datadog statsd.
- Unit test command handlers and golden-file diff outputs.

## Deliverables
- README with installation steps, command reference, and CI usage examples.
- Contribution guide for adding new exporters or token formats.
EOT

    "codefast-day-28-feature-flags" = <<-EOT
# Codefast Day 28 · Feature Flags

## Mission
- Build a feature flag service integrating LaunchDarkly-style targeting with configuration UI and audits.

## Implementation Checklist
1. Model flags, environments, and targeting rules with Prisma, exposing typed APIs.
2. Provide management UI with percentage rollouts, prerequisites, and change history.
3. Emit evaluation telemetry to Datadog, correlating with UX metrics.
4. Add SDK snippets for Next.js apps with offline bootstrap and fallback logic.

## Telemetry & QA
- Ensure audit log coverage for all changes and add alerting for long-lived experiments.
- Unit test rule evaluation engine and integration tests for rollout workflows.

## Deliverables
- README covering architecture, SDK integration, and incident response.
- Policy document defining flag lifecycle and cleanup expectations.
EOT

    "codefast-day-29-onboarding-checklist" = <<-EOT
# Codefast Day 29 · Onboarding Checklist

## Mission
- Create an animated onboarding checklist with progress sync, localization, and user personalization.

## Implementation Checklist
1. Store steps in CMS/JSON with localization keys and progress weights.
2. Animate transitions using Framer Motion while respecting reduced-motion settings.
3. Persist progress online/offline and sync to backend when authenticated.
4. Tie completion telemetry to Datadog RUM and send summary emails to mentors.

## Telemetry & QA
- A/B test different step orders and track completion funnels.
- Integration tests for offline usage, localization, and animation fallbacks.

## Deliverables
- README describing checklist schema, animation guidelines, and integration hooks.
- Support guide for updating steps without redeploying.
EOT

    "codefast-day-30-experience-quality-report" = <<-EOT
# Codefast Day 30 · Experience Quality Report

## Mission
- Automate weekly experience reports blending Datadog RUM, SEO trends, and design token drift analysis.

## Implementation Checklist
1. Schedule pipelines that ingest metrics, token diffs, and SEO rankings into a unified dataset.
2. Generate Markdown/PDF reports with charts, narrative insights, and remediation owners.
3. Publish reports to GitHub releases and distribute via email/Slack with tracked engagement.
4. Maintain historical trend dashboards and retention policies for raw data.

## Telemetry & QA
- Alert when data feeds fail or anomalies exceed thresholds.
- Unit test report generators and snapshot outputs for reproducibility.

## Deliverables
- README detailing pipeline schedule, report format, and review cadence.
- Follow-up template for assigning action items to squads.
EOT

    "repo-as-a-code" = <<-EOT
# Repo as Code

## Mission
- Manage GitHub repositories declaratively via Terraform, including repos, permissions, and bootstrap files.

## Implementation Checklist
1. Keep Terraform modules updated, locking provider versions in `.terraform.lock.hcl`.
2. Document new repository onboarding workflow, including naming, visibility, and default READMEs.
3. Automate plan/apply via CI with workspaces per environment.
4. Maintain linting, security scanning, and drift detection policies.

## Telemetry & QA
- Monitor Terraform runs, GitHub API quotas, and failed applies.
- Add unit tests for helper modules using `terraform test` and golden outputs.

## Deliverables
- README describing layout, environment setup, and contribution guidelines.
- Runbook for responding to failed applies or provider rate limits.
EOT

    "elk_services" = <<-EOT
# elk_services

## Mission
- Provide automation scripts akin to Ansible ad-hoc commands, orchestrated via iTerm2 for ELK stack tasks.

## Implementation Checklist
1. Document script entry points, parameters, and prerequisite environment variables.
2. Add tests or dry-run modes that validate commands without mutating infrastructure.
3. Integrate logging/metrics to track script execution and failures.
4. Provide examples for onboarding, scaling, and backup operations.

## Telemetry & QA
- Capture execution metrics in Datadog; alert on failures or long runtimes.
- Add linting/formatting for shell/Python scripts.

## Deliverables
- README detailing setup, commands, and safety guidelines.
- Contribution checklist for adding new automation routines.
EOT

    "magzim21" = <<-EOT
# magzim21

## Mission
- Maintain bio and links with a focus on accessibility, localization, and analytics.

## Implementation Checklist
1. Outline content architecture, translations, and SEO metadata.
2. Track outbound link interactions via Datadog RUM.
3. Provide CI pipeline ensuring markdown/links stay valid.

## Deliverables
- README summarizing content strategy, tech stack, and deployment steps.
- Checklist for updating social links and verifying accessibility.
EOT

    "obsidian-notes" = <<-EOT
# Obsidian Notes

## Mission
- Manage private knowledge base syncing workflows and backup strategy.

## Implementation Checklist
1. Define folder structure, templates, and Obsidian plugin governance.
2. Document sync tooling (Git, iCloud, etc.) with conflict resolution steps.
3. Automate encrypted backups and rotation policies.

## Deliverables
- README with setup instructions, security practices, and maintenance cadence.
- Runbook for restoring notes from backup.
EOT

    "quick_ops" = <<-EOT
# quick_ops

## Mission
- Provide scripting toolkit similar to Ansible ad-hoc commands.

## Implementation Checklist
1. Catalog available scripts, parameters, and dependencies.
2. Add tests or linting to ensure scripts remain idempotent.
3. Document logging/telemetry integration.

## Deliverables
- README covering usage examples, safety notes, and contribution flow.
- Change log capturing new scripts or updates.
EOT

    "quick-ops" = <<-EOT
# quick-ops

## Mission
- Companion repository for quick_ops with alternative implementations.

## Implementation Checklist
1. Document overlap/differences with `quick_ops`.
2. Provide install instructions and environment setup.
3. Add lint/test coverage.

## Deliverables
- README outlining scripts, usage, and maintenance plan.
- Checklist for cross-repo synchronization.
EOT

    "job_parser" = <<-EOT
# job_parser

## Mission
- Maintain Dockerized job parser with Selenium, Telegram bot, and logging stack.

## Implementation Checklist
1. Document container architecture, environment variables, and scaling strategy.
2. Outline data flow from scraping to notifications.
3. Provide observability setup with Elasticsearch/Kibana or Datadog.

## Deliverables
- README covering deployment, local dev, and troubleshooting.
- Runbook for scraping failures and selector changes.
EOT

    "Kanban-Board" = <<-EOT
# Kanban Board

## Mission
- JavaScript final exam project; maintain documentation, tests, and deployment options.

## Implementation Checklist
1. Describe feature set, data persistence strategy, and UI interactions.
2. Add unit tests for core logic and linting pipeline.
3. Provide instructions for running locally and deploying (Netlify/Vercel).

## Deliverables
- README with screenshots, setup steps, and evaluation rubric alignment.
- Backlog of potential improvements.
EOT

    "terragrunt-sync" = <<-EOT
# terragrunt-sync

## Mission
- Manage Terragrunt configurations with emphasis on DRY modules and environment sync.

## Implementation Checklist
1. Document folder structure, module hierarchy, and dependency graph.
2. Provide commands for plan/apply per environment.
3. Outline secrets management, remote state, and linting.

## Deliverables
- README with onboarding guide, naming conventions, and drift detection process.
- ADR for major architectural decisions.
EOT

    "ship-fast-ts" = <<-EOT
# ship-fast-ts

## Mission
- Next.js boilerplate to ship quickly with TypeScript, testing, and CI.

## Implementation Checklist
1. Document module structure, codegen steps, and design tokens.
2. Include instructions for enabling SEO, analytics, and authentication.
3. Provide testing strategy (unit, integration, lint).

## Deliverables
- README with setup, customization guide, and release workflow.
- Template issues for consumers to request features.
EOT

    "english-new" = <<-EOT
# english-new

## Mission
- Manage English learning materials, exercises, and localization.

## Implementation Checklist
1. Outline curriculum structure, file naming, and review cadence.
2. Document tooling for flashcards/quizzes and analytics on progress.
3. Provide contribution guidelines for adding new lessons.

## Deliverables
- README describing study plan, resources, and update workflow.
- Template for lesson reviews.
EOT

    "template" = <<-EOT
# Template Repository

## Mission
- Serve as GitHub template with multiple branches and GitHub Pages configuration.

## Implementation Checklist
1. Document branch purposes (`gh-pages`, `wtf`, `prod`) and merge strategy.
2. Provide instructions for customizing README, workflows, and Pages deployment.
3. Include sample issues/PR templates.

## Deliverables
- README outlining template usage, configuration knobs, and bootstrap steps.
- Maintenance checklist for keeping dependencies current.
EOT

    "crypto-seed-phrase-generator" = <<-EOT
# Crypto Seed Phrase Generator

## Mission
- Provide secure seed phrase generation with clear warnings and usage guidelines.

## Implementation Checklist
1. Document cryptographic libraries, entropy sources, and validation steps.
2. Include security checklist and threat model summary.
3. Offer CLI/GUI usage instructions and testing strategy.

## Deliverables
- README with security best practices, disclaimers, and contribution policy.
- Runbook for dependency updates and security audits.
EOT

    "dotfiles" = <<-EOT
# Dotfiles

## Mission
- Manage personal dotfiles with bootstrap script, backups, and documentation.

## Implementation Checklist
1. Outline installation script, supported shells, and dependency management.
2. Document machine-specific overrides and secrets handling.
3. Provide testing strategy (linting, shellcheck).

## Deliverables
- README with setup instructions, customization options, and update workflow.
- Checklist for onboarding new machines.
EOT

    "safedial" = <<-EOT
# Safedial

## Mission
- Password checker CLI; document architecture, dependencies, and security posture.

## Implementation Checklist
1. Describe hashing strategy, breached password lookup, and rate limiting.
2. Provide install instructions and sample commands.
3. Add tests covering CLI arguments and edge cases.

## Deliverables
- README with usage examples, security warnings, and contribution guide.
- Maintenance plan for updating breach databases.
EOT

    "elevate-sec" = <<-EOT
# Elevate Security

## Mission
- Archive of security project; ensure documentation and historical context remain accessible.

## Implementation Checklist
1. Summarize goals, architecture, and technologies used.
2. Note reasons for archiving and how to revive project if needed.
3. Provide references to related active projects.

## Deliverables
- README with project history, lessons learned, and archival instructions.
- Checklist for reactivation if future work resumes.
EOT

    "magz8s" = <<-EOT
# magz8s

## Mission
- Document EKS installation with best practices, automation scripts, and observability.

## Implementation Checklist
1. Outline infrastructure layout, Terraform/Helm modules, and networking.
2. Provide cluster bootstrap steps, IAM roles, and security controls.
3. Document monitoring stack and logging integrations.

## Deliverables
- README with architecture diagrams, deployment steps, and maintenance tasks.
- Runbook for cluster upgrades and incident response.
EOT

    "kubespray-lite" = <<-EOT
# Kubespray Lite

## Mission
- Terraform/Ansible combo for AWS EC2 + Kubernetes using Kubespray.

## Implementation Checklist
1. Document prerequisites, inventory layout, and configuration variables.
2. Provide workflow for provisioning, scaling, and tearing down clusters.
3. Note monitoring/logging setup and security hardening tips.

## Deliverables
- README with step-by-step guide, troubleshooting, and cost considerations.
- Checklist for validating cluster health post-deploy.
EOT

    "magzim21.github.io" = <<-EOT
# magzim21.github.io

## Mission
- Personal website with GitHub Pages; ensure performance, SEO, and localization.

## Implementation Checklist
1. Document build process, branch strategy (`gh-pages`), and deployment scripts.
2. Outline content updates, asset optimization, and analytics instrumentation.
3. Provide accessibility checklist and testing commands.

## Deliverables
- README with local dev setup, deployment workflow, and maintenance schedule.
- Issue templates for content updates and bug reports.
EOT

    "aws_terraform" = <<-EOT
# AWS Terraform

## Mission
- ASG + ELB infrastructure stack; document architecture and operations.

## Implementation Checklist
1. Describe module layout, variables, and outputs.
2. Provide instructions for environment-specific overrides and remote state.
3. Note monitoring/alerting setup and cost considerations.

## Deliverables
- README with plan/apply workflow, rollback strategy, and testing approach.
- Runbook for scaling events and incident response.
EOT

    "Ansible-gather-information" = <<-EOT
# Ansible Gather Information

## Mission
- Role for collecting infrastructure facts; document usage and customization.

## Implementation Checklist
1. Describe dependencies, supported platforms, and variables.
2. Provide playbook examples and sample outputs.
3. Add tests with `molecule` or similar frameworks.

## Deliverables
- README with installation, usage, and extension guidance.
- Checklist for adding new facts or hosts.
EOT

    "ansible_change_hostnames" = <<-EOT
# Ansible Change Hostnames

## Mission
- Batch rename hostnames; ensure systemd/init compatibility and safety.

## Implementation Checklist
1. Document playbook variables, prerequisites, and rollback steps.
2. Provide verification commands for post-change validation.
3. Include tests or dry-run examples.

## Deliverables
- README with usage scenarios, warnings, and troubleshooting.
- Runbook for mass hostname updates.
EOT

    "zabbix_agents_ansible" = <<-EOT
# Zabbix Agents Ansible

## Mission
- Install Zabbix agents at scale; document role configuration and monitoring.

## Implementation Checklist
1. Outline inventory structure, role arguments, and version management.
2. Provide automation for certificate deployment and firewall changes.
3. Add health checks ensuring agents register successfully.

## Deliverables
- README with install steps, verification commands, and maintenance tasks.
- Checklist for onboarding new host groups.
EOT

    "docker-zabbix-mysql" = <<-EOT
# Docker Zabbix MySQL

## Mission
- Containerized Zabbix + MySQL stack; document orchestration and persistence.

## Implementation Checklist
1. Detail docker-compose/k8s manifests, volumes, and networking.
2. Provide backup/restore instructions for MySQL and Zabbix configuration.
3. Include monitoring and logging guidance.

## Deliverables
- README with setup, scaling, and troubleshooting steps.
- Maintenance schedule for upgrades and security patches.
EOT

    "OOP-csv-editor" = <<-EOT
# OOP CSV Editor

## Mission
- Console CSV editor project; outline architecture and feature roadmap.

## Implementation Checklist
1. Document class structure, command handling, and storage format.
2. Provide usage examples and sample datasets.
3. Add unit tests covering parsing, editing, and exporting.

## Deliverables
- README with instructions, limitations, and future enhancements.
- Template for bug reports.
EOT

    "Django-Flowers-Shop" = <<-EOT
# Django Flowers Shop

## Mission
- Course work project; ensure documentation, testing, and deployment guidance.

## Implementation Checklist
1. Outline app structure, key models, and payment/inventory flows.
2. Provide instructions for local dev, fixtures, and running tests.
3. Document deployment targets (Heroku/AWS) and environment variables.

## Deliverables
- README with screenshots, feature list, and grading notes.
- Maintenance checklist for dependencies and security updates.
EOT

    "PHP-MySQL-JS_Payroll_System" = <<-EOT
# PHP/MySQL/JS Payroll System

## Mission
- EPAM test task; document architecture, security, and deployment steps.

## Implementation Checklist
1. Explain database schema, authentication, and payroll calculations.
2. Provide setup instructions, sample data, and testing notes.
3. Document security considerations and hardening steps.

## Deliverables
- README with feature overview, installation guide, and troubleshooting.
- Checklist for migrating to modern stack when needed.
EOT

    "Rolling-dice-game" = <<-EOT
# Rolling Dice Game

## Mission
- Simple console game; document rules, architecture, and extension ideas.

## Implementation Checklist
1. Detail game flow, scoring, and randomness sources.
2. Provide compilation/run instructions for target languages.
3. Add tests for core logic where feasible.

## Deliverables
- README with gameplay examples, customization tips, and future enhancements.
- Template for contributions.
EOT

    "Parking-app" = <<-EOT
# Parking App

## Mission
- Python OOP practice; document architecture, data models, and CLI/UI usage.

## Implementation Checklist
1. Describe class design, state management, and persistence.
2. Provide instructions for running, testing, and extending features.
3. Outline logging/monitoring strategies.

## Deliverables
- README with feature list, setup steps, and refactor roadmap.
- Bug triage checklist.
EOT

    "Registration-form" = <<-EOT
# Registration Form

## Mission
- Training task; document validation rules, accessibility, and backend integration.

## Implementation Checklist
1. Explain form structure, field requirements, and client/server validation.
2. Provide instructions for running locally and deploying.
3. Include testing strategy for validation and error states.

## Deliverables
- README with walkthrough, screenshot, and extension ideas.
- QA checklist for form updates.
EOT
  }
}

