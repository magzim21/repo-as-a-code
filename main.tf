locals {
  repos = [
    {
      name        = "ims-lp"
      description = "IMS Landing Page"
      visibility  = "public"
      topics      = ["html", "css", "javascript", ]
      archived    = false
      template = {
        owner                = "codelawcorp"
        repository           = "template"
        include_all_branches = false
      }
      pages = {
        build_type = "workflow"
      }
      repository_files = {
        ".github/workflows/main.yaml" = {
          content             = templatefile("templates/gha/pages.yaml.tpl", {})
          commit_message      = "fix(semantic-release): determine the next version"
          overwrite_on_create = true
        }
        "README.md" = {
          content             = local.repo_readmes["ims-lp"]
          overwrite_on_create = true
        }
      }
      has_issues      = false
      has_projects    = false
      has_wiki        = false
      has_discussions = false

      archive_on_destroy = false
    },
    {
      name        = "frontendmentor"
      description = "Practice HTML, CSS, and JavaScript by building real-world projects."
      visibility  = "private"
      topics      = ["html", "css", "javascript", ]
      archived    = false
      template = {
        owner                = "codelawcorp"
        repository           = "template"
        include_all_branches = false
      }
      # pages = {
      #   build_type = "workflow"
      # }
      has_issues      = false
      has_projects    = false
      has_wiki        = false
      has_discussions = false

      archive_on_destroy = false
    },
    {
      name        = "aws-infra-personal"
      description = "AWS infrastructure for personal use"
      visibility  = "private"
      topics      = ["aws", "infrastructure", "personal"]
      archived    = false
      template = {
        owner                = "codelawcorp"
        repository           = "template"
        include_all_branches = false
      }
      actions_variables = [
        {
          name  = "TERRAFORM_VERSION"
          value = "1.14.5"
        },
        {
          name  = "AWS_ACCOUNT_ID"
          value = data.aws_caller_identity.current.account_id
        },
        {
          name  = "AWS_REGION"
          value = "us-east-1"
        },
        {
          name  = "IAM_GHA_OIDC_ROLE_NAME"
          value = "github-actions-role"
        },
      ]
      # pages = {
      #   build_type = "workflow"
      # }
      has_issues      = false
      has_projects    = false
      has_wiki        = false
      has_discussions = false

      archive_on_destroy = false
    },
    {
      name        = "finance-simulation"
      description = "Finance simulation"
      visibility  = "private"
      topics      = ["finance", "simulation"]
      archived    = false
      template = {
        owner                = "codelawcorp"
        repository           = "template"
        include_all_branches = false
      }
      # pages = {
      #   build_type = "workflow"
      # }
      has_issues      = false
      has_projects    = false
      has_wiki        = false
      has_discussions = false

      archive_on_destroy = false
    },
    {
      name        = "canada-immigration-news"
      description = "Monitor Canada PR fast tracks"
      visibility  = "private"
      topics      = ["canada", ]
      archived    = false
      template = {
        owner                = "codelawcorp"
        repository           = "template"
        include_all_branches = false
      }
      # pages = {
      #   build_type = "workflow"
      # }
      has_issues      = false
      has_projects    = false
      has_wiki        = false
      has_discussions = false

      archive_on_destroy = false
    },
    {
      name        = "save-the-world"
      description = "Save the world by backing up git repositories"
      visibility  = "public"
      topics      = ["backup", "git"]
      archived    = false
      template = {
        owner                = "codelawcorp"
        repository           = "template"
        include_all_branches = false
      }
      pages = {
        build_type = "workflow"
      }
      has_issues      = true
      has_projects    = true
      has_wiki        = false
      has_discussions = true
    },
    # {
    #   name        = "codefast-day-01-next-api-gallery"
    #   description = "Day 1/30: Ship a Next.js gallery that fetches a public API and renders statically generated cards."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-01-next-api-gallery"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-02-next-landing-page"
    #   description = "Day 2/30: Build a marketing landing page in Next.js with responsive Tailwind components and metadata."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-02-next-landing-page"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-03-next-mdx-blog"
    #   description = "Day 3/30: Create an MDX-powered blog in Next.js with dynamic routing and syntax highlighting."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-03-next-mdx-blog"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-04-next-pagination-lab"
    #   description = "Day 4/30: Prototype cursor-based pagination with resilient fallbacks, skeleton states, and API error boundaries."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-04-next-pagination-lab"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-05-next-seo-playbook"
    #   description = "Day 5/30: Automate lighthouse-backed SEO audits in Next.js with sitemap generation and hreflang coverage."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-05-next-seo-playbook"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-06-seo-ab-testing"
    #   description = "Day 6/30: Run server-side SEO experiments with dynamic metadata and automated canonical validation."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-06-seo-ab-testing"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-07-figma-token-sync"
    #   description = "Day 7/30: Keep tokens synced from Figma into JSON, Style Dictionary, and Tailwind layers on each push."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-07-figma-token-sync"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-08-design-token-ci"
    #   description = "Day 8/30: Build a pipeline that validates tokens synced from Figma against production CSS and flags drift."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-08-design-token-ci"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-09-datadog-rum-instrumentation"
    #   description = "Day 9/30: Instrument Datadog RUM across Next.js routes with user journey tagging and session replay."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-09-datadog-rum-instrumentation"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-10-rum-alerting"
    #   description = "Day 10/30: Analyze Datadog RUM signals for Core Web Vitals regressions and notify on Slack."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-10-rum-alerting"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-11-notion-sync"
    #   description = "Day 11/30: Build a Notion content sync CLI that mirrors docs into a Markdown repo."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-11-notion-sync"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-12-lesson-scheduler"
    #   description = "Day 12/30: Create a lesson scheduler that syncs Codefa.st modules with Google Calendar." # 
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-12-lesson-scheduler"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-13-multi-api-atlas"
    #   description = "Day 13/30: Build a multi-API command center with geospatial map overlays, latency heatmaps, and localization toggles."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-13-multi-api-atlas"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-14-aceternity-theme-lab"
    #   description = "Day 14/30: Scaffold a theme editor that mirrors ui.aceternity.com palettes with live token previews."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-14-aceternity-theme-lab"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-15-offline-sync-queue"
    #   description = "Day 15/30: Persist fetched data and file uploads in IndexedDB, reconcile on reconnect, and dispatch queued emails."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-15-offline-sync-queue"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-16-component-token-diff"
    #   description = "Day 16/30: Diff design tokens across branches and surface breaking changes in Shadcn component stories."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-16-component-token-diff"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-17-rum-seo-correlation"
    #   description = "Day 17/30: Correlate Datadog RUM metrics with SEO rankings to surface pages with degraded UX."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-17-rum-seo-correlation"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-18-certificate-generator"
    #   description = "Day 18/30: Generate personalized course completion certificates using PDFKit and edge functions."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-18-certificate-generator"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-19-shad-cdn-publisher"
    #   description = "Day 19/30: Publish a shad cdn component bundle with versioned exports and integrity metadata."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-19-shad-cdn-publisher"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-20-shad-cdn-auditor"
    #   description = "Day 20/30: Audit shad cdn usage to recommend accessible variants and tree-shakable imports."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-20-shad-cdn-auditor"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-21-quality-guardrails"
    #   description = "Day 21/30: Enforce API error boundaries with synthetic probes, unit-tested handlers, and file-based fixtures."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-21-quality-guardrails"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-22-kanban"
    #   description = "Day 22/30: Deliver a drag-and-drop Kanban planner with server actions and optimistic updates."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-22-kanban"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-23-search"
    #   description = "Day 23/30: Ship a knowledge base search experience using Algolia and instant faceting."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-23-search"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-24-cohort-metrics"
    #   description = "Day 24/30: Compute SaaS cohort and retention metrics with SQL models and charts."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-24-cohort-metrics"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-25-reminder-pwa"
    #   description = "Day 25/30: Launch a mobile-first PWA for daily practice reminders with push notifications."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-25-reminder-pwa"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-26-seo-rum-dashboard"
    #   description = "Day 26/30: Ship a combined SEO and RUM insights dashboard with anomaly detection and executive summaries."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-26-seo-rum-dashboard"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-27-figma-token-cli"
    #   description = "Day 27/30: Provide a CLI to sync Figma tokens across repos with change logs and GitHub check outputs."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-27-figma-token-cli"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-28-feature-flags"
    #   description = "Day 28/30: Build a feature flag service integrating LaunchDarkly and configuration UI."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-28-feature-flags"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-29-onboarding-checklist"
    #   description = "Day 29/30: Create an animated onboarding checklist with Framer Motion and progress sync."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-29-onboarding-checklist"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },
    # {
    #   name        = "codefast-day-30-experience-quality-report"
    #   description = "Day 30/30: Automate weekly experience quality reports blending Datadog RUM, SEO, and design token drift."
    #   visibility  = "public"
    #   topics      = ["codefast"]
    #   template = {
    #     owner                = "codelawcorp"
    #     repository           = "template"
    #     include_all_branches = false
    #   }
    #   pages = {
    #     build_type = "workflow"
    #   }
    #   repository_files = {
    #     ".github/workflows/main.yaml" = {
    #       content             = templatefile("templates/gha/pages.yaml.tpl", {})
    #       commit_message      = "fix(semantic-release): determine the next version"
    #       overwrite_on_create = true
    #     }
    #     "README.md" = {
    #       content             = local.repo_readmes["codefast-day-30-experience-quality-report"]
    #       overwrite_on_create = true
    #     }
    #   }
    #   archive_on_destroy = false
    # },

    {
      name        = "repo-as-a-code" # This repo
      description = "This repository manages itself as code. Also it will manage other repositories in the future."
      visibility  = "public"
      archived    = false
      is_template = false

      environments = [
        {
          name = "prod"
          secrets = [
            # {
            #   name  = "pat_token"
            #   value = "Creaate it manually in the GitHub Actions UI"
            # },
          ]
        },
      ]
      actions_variables = [
        {
          name  = "TERRAFORM_VERSION"
          value = "1.14.5"
        },
        {
          name  = "AWS_ACCOUNT_ID"
          value = data.aws_caller_identity.current.account_id
        },
        {
          name  = "AWS_REGION"
          value = "us-east-1"
        },
        {
          name  = "IAM_GHA_OIDC_ROLE_NAME"
          value = "github-actions-role"
        },
      ]
      actions_secrets = [
      ]
    },
    {
      name        = "elk_services"
      description = "Scripting magic. Like Ansible ad-hoc but with iterm2"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "magzim21"
      description = "My bio and links"
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "obsidian-notes"
      description = "Knowldege notes. Aka second brain."
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name        = "quick-ops"
      description = "Sripting magic. Like Ansible ad-hoc but with iterm2"
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "job_parser"
      description = "Docker, AWS EB, BeautifulSoup, Selenium, Telegram-bot, psycopg2, logging. Also: chrome, Xpra (virtual display)."
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },
    {
      name        = "Kanban-Board"
      description = "Java Script Advanced ITEA final exam"
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "terragrunt-sync"
      description = ""
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name         = "ship-fast-ts"
      description  = "The NextJs boilerplate to ship. FAST. ⚡️"
      visibility   = "private"
      archived     = false
      is_template  = false
      fork         = true
      source_owner = "Marc-Lou-Org"
      source_repo  = "ship-fast-ts"
    },
    {
      name        = "english-new"
      description = ""
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name        = "template"
      description = "This is a repo template 👨🏼‍🔬"
      visibility  = "public"
      archived    = false
      is_template = true
      branches = [
        {
          name = "gh-pages"
        },
        {
          name = "prod"
        }
      ]
      pages = { // GitHub provider issue: gh-pages branch must exist at applytime / bootstrap problem
      }

    },
    {
      name        = "crypto-seed-phrase-generator"
      description = ""
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "dotfiles"
      description = ""
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name           = "safedial"
      description    = "A password checker CLI tool ☘️"
      visibility     = "public"
      archived       = true
      default_branch = "main"
      is_template    = false
    },
    {
      name           = "elevate-sec"
      description    = ""
      visibility     = "public"
      archived       = true
      default_branch = "main"
      is_template    = false
    },
    {
      name           = "magz8s"
      description    = "EKS installation with best practices"
      visibility     = "public"
      archived       = true
      default_branch = "main"
      is_template    = false
    },
    {
      name        = "kubespray-lite"
      description = "aws ec2, terraform, ansible, kubernetes"
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },
    {
      name        = "magzim21.github.io"
      description = "Personal website"
      visibility  = "public"
      archived    = false
      is_template = false
      # enable_dependabot_security_updates = false
      branches = [
        {
          name = "gh-pages"
        }
      ]
      pages = { // GitHub provider issue: pages branch must exist at applytime / bootstrap problem
        build_type = "legacy"
        source = {
          branch = "gh-pages"
          path   = "/"
        }
        cname = "${data.aws_route53_zone.this.name}"
        # cname = "wtf"
      }
    },
    {
      name           = "aws_terraform"
      description    = "ASG(EC2) + ELB"
      visibility     = "public"
      archived       = true
      default_branch = "main"
      is_template    = false
    },
    {
      name        = "Ansible-gather-information"
      description = "This Ansible role use useful for those freshmans who just came to project and not familiar with infrastructure etc."
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "ansible_change_hostnames"
      description = "ANSIBLE batch rename hostnames. It works with systemd, but can easily be adopted for init systems."
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "zabbix_agents_ansible"
      description = "This is a simple playbook for mass installing zabbix agents. "
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "docker-zabbix-mysql"
      description = ""
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },
    {
      name        = "OOP-csv-editor"
      description = "Console CSV editor with OOP"
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },
    {
      name        = "Django-Flowers-Shop"
      description = "ITEA course work. I have got RED diploma on it."
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },
    {
      name        = "PHP-MySQL-JS_Payroll_System"
      description = "epam test task"
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },
    {
      name        = "Rolling-dice-game"
      description = "Simple console gambling game"
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },
    {
      name        = "Parking-app"
      description = "OOP practice with python"
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },
    {
      name        = "Registration-form"
      description = "training task"
      visibility  = "public"
      archived    = true
      # default_branch = "main"
      is_template = false
    },

  ]

  index_html_default_body = "This repository is managed with Terraform. Review the README for project details."
}
module "repos" {
  for_each = { for repo in local.repos : repo.name => repo }

  # Swap sources. These docs are autogenerated.
  source  = "codelawcorp/repository/github"
  version = "4.2.4"
  # version = "~> 2.0.0" # It is always recommended to pin version

  name        = try(each.value.name, null)
  description = try(each.value.description, null)
  visibility  = try(each.value.visibility, null)

  homepage_url = try(each.value.homepage_url, each.value.pages.cname, each.value.pages != null ? "${each.value.name}.${data.aws_route53_zone.this.name}" : null, null)
  fork         = try(each.value.fork, null)
  source_owner = try(each.value.source_owner, null)
  source_repo  = try(each.value.source_repo, null)


  archived    = try(each.value.archived, null)
  is_template = try(each.value.is_template, null)

  # topics       = try(each.value.topics, [])
  topics = try(each.value.topics, [])

  has_projects    = try(each.value.has_projects, null)
  has_wiki        = try(each.value.has_wiki, null)
  has_downloads   = try(each.value.has_downloads, null)
  has_discussions = try(each.value.has_discussions, null)

  # Merge settings
  allow_auto_merge       = try(each.value.allow_auto_merge, null)
  allow_merge_commit     = try(each.value.allow_merge_commit, null)
  allow_squash_merge     = try(each.value.allow_squash_merge, null)
  allow_rebase_merge     = try(each.value.allow_rebase_merge, null)
  delete_branch_on_merge = try(each.value.delete_branch_on_merge, null)

  merge_commit_title          = try(each.value.merge_commit_title, null)
  merge_commit_message        = try(each.value.merge_commit_message, null)
  squash_merge_commit_title   = try(each.value.squash_merge_commit_title, null)
  squash_merge_commit_message = try(each.value.squash_merge_commit_message, null)




  # Template configuration (if using a template repository)
  template = try(each.value.template, null)


  default_branch    = try(each.value.default_branch, "prod", null)
  branches          = try(each.value.branches, null)
  custom_properties = []



  deploy_keys = []

  #   # GitHub Pages configuration (optional)
  pages = try(each.value.pages, null) != null ? {
    build_type = try(each.value.pages.build_type, "workflow")
    cname      = try(each.value.pages.cname, "${each.value.name}.${data.aws_route53_zone.this.name}", null)
    # source = try(each.value.pages.source, null)
    source = try(each.value.pages.source, null) != null ? {
      branch = try(each.value.pages.source.branch, "gh-pages")
      path   = try(each.value.pages.source.path, "/")
    } : null
  } : null

  environments = try(each.value.environments, null)

  actions_variables = try(each.value.actions_variables, null)

  actions_secrets = try(each.value.actions_secrets, null)

  # This also automatically enables vulnerability_alerts
  # vulnerability_alerts               = true
  # enable_dependabot_security_updates = try(each.value.enable_dependabot_security_updates, true, null)


  # Configure webhooks for the repository
  webhooks = try(each.value.webhooks, null)





  users = try(each.value.users, null)

  teams = try(each.value.teams, null)

  # Add GitHub repository files
  repository_files = (
    try(each.value.archived, false)
    ? {}
    : merge(
      try(each.value.pages, null) != null ? {
        "index.html" = {
          content = templatefile(
            "${path.module}/templates/index.html.tpl",
            {
              title   = try(each.value.name, "Repository")
              heading = try(each.value.name, "Repository")
              lede = try(
                trimspace(each.value.description) != "" ? trimspace(each.value.description) : local.index_html_default_body,
                local.index_html_default_body
              )
            }
          )
          overwrite_on_create = true
        }
      } : {},
      try(each.value.repository_files, {})
    )
  )

  # Add issue labels
  issue_labels = try(each.value.issue_labels, [])

  # Create an autolink reference
  autolink_references = [
  ]

  # gitignore_template = "Python"
  # license_template   = "mit"

  # actions_repository_permissions = {
  #   allowed_actions = "selected"
  #   enabled         = true
  #   allowed_actions_config = {
  #     github_owned_allowed = true
  #     patterns_allowed     = ["actions/*"]
  #     verified_allowed     = true
  #   }
  # }

  # Projects are not supported by this module.
  # 410 Projects (classic) has been deprecated in favor of the new Projects experience. []

  archive_on_destroy = try(each.value.archive_on_destroy, null)
}



data "aws_route53_zone" "this" {
  name = "maxim.run."
}


resource "aws_route53_record" "this_cname" {
  for_each = {
    for repo in local.repos : repo.name => repo if try(repo.pages, null) != null && try(repo.pages.cname, null) != data.aws_route53_zone.this.name
  }
  zone_id = data.aws_route53_zone.this.zone_id
  name    = try(each.value.pages.cname, null) != null ? each.value.pages.cname : "${each.key}.${data.aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "magzim21.github.io"
  ]
}

resource "aws_route53_record" "this_a" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = data.aws_route53_zone.this.name
  type    = "A"
  ttl     = "300"
  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
}

resource "aws_route53_record" "this_aaaa" {
  name    = data.aws_route53_zone.this.name
  zone_id = data.aws_route53_zone.this.zone_id
  type    = "AAAA"
  ttl     = "300"
  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153"
  ]
}


# https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/verifying-your-custom-domain-for-github-pages#verifying-a-domain-for-your-user-site
resource "aws_route53_record" "txt_verification" {

  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_github-pages-challenge-magzim21.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = "300"
  records = [
    "69e2555f9da01b3b9b11d2005fb9a2"
  ]
}