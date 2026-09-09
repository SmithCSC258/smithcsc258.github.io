---
layout: home
title: Just the Class
nav_exclude: true
permalink: /:path/
seo:
  type: Course
  name: CSC 210
---

# Just the Class

Just the Class is a GitHub Pages template developed for the purpose of quickly deploying course websites. In addition to serving plain web pages and files, it provides a boilerplate for:

- [announcements](announcements.md),
- a [course topics page](topics.md),
- a [staff](staff.md) page,
- and a weekly [schedule](schedule.md).

Site infrastructure credit: https://github.com/kevinlin1/just-the-class

Just the Class is a template that extends the popular [Just the Docs](https://github.com/just-the-docs/just-the-docs) theme, which provides a robust and thoroughly-tested foundation for your website. Just the Docs include features such as:

- automatic [navigation structure](https://just-the-docs.github.io/just-the-docs/docs/navigation-structure/),
- instant, full-text [search](https://just-the-docs.github.io/just-the-docs/docs/search/) and page indexing,
- and a set of [UI components](https://just-the-docs.github.io/just-the-docs/docs/ui-components) and authoring [utilities](https://just-the-docs.github.io/just-the-docs/docs/utilities).

## Getting Started

Getting started with Just the Class is simple.

1. Create a new repository based on the course template.
1. Update `_config.yml` and `README.md` with your course information. [Be sure to update the url and baseurl](https://mademistakes.com/mastering-jekyll/site-url-baseurl/).
1. Configure a [publishing source for GitHub Pages](https://help.github.com/en/articles/configuring-a-publishing-source-for-github-pages). Your course website is now live!
1. Edit and create `.md` [Markdown files](https://guides.github.com/features/mastering-markdown/) to add more content pages.

## Course workflow (CSC 210)

### Schedule generation

The topics page is maintained in `topics.md`. Weekly module files in `_modules/` are generated from `_data/schedule.yml`.

To regenerate modules after editing the data file:

```bash
ruby scripts/generate_schedule.rb
```

### Slides (PPTX + PDF)

- Source slides: `content/slides-source/` (PowerPoint `.pptx`)
- Web PDFs: `assets/slides/` (exported PDFs linked from the schedule)

Large binary files are tracked via Git LFS. After cloning, run:

```bash
git lfs install
```

### Gradescope links

Add assignment entries in `_data/schedule.yml` under `assignments`, then reference them by `id` in a session’s `assignments_due` list. The generator will add a "Gradescope" link next to the due label.
You can also set `term.assignment_due_day` and `term.assignment_due_time` to stamp due labels like "(Tuesday 11:59 PM)".

### Updating dates each semester

1. Update `term.start_date` and any `skip_ranges`/`special_dates` in `_data/schedule.yml`.
2. Run `ruby scripts/generate_schedule.rb` to rebuild `_modules/*.md`.

### Topics-driven schedule workflow

1. Edit `content/Schedule-CSC210-Topics.csv` with Week/Day/Topic entries.
2. Update `_data/term.yml` with the semester start date, meeting days, and skip dates/ranges.
3. Run:

```
ruby scripts/import_schedule_csv.rb
ruby scripts/generate_schedule.rb
```

To handle a one-off closure like Mountain Day, add the date to `_data/term.yml` under `skip_dates`,
then rerun the two scripts to shift the remaining topics forward.

### Hosting slides externally

If you host slides on Smith’s server, set `term.slides_base_url` and `term.slides_pptx_base_url` in
`_data/term.yml`. The generator will link each topic to the PDF and add a PPTX link automatically.

This template has been used for a variety of course websites across institutions.

### Local development environment

Just the Class requires no special Jekyll plugins and can run on GitHub Pages' standard Jekyll compiler. To setup a local development environment, clone your template repository and follow the GitHub Docs on [Testing your GitHub Pages site locally with Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll).
