#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "yaml"

ROOT = File.expand_path("..", __dir__)
DATA_PATH = File.join(ROOT, "_data", "schedule.yml")
MODULES_DIR = File.join(ROOT, "_modules")

def load_data(path)
  YAML.safe_load(File.read(path), permitted_classes: [Date], permitted_symbols: [], aliases: false)
end

def wday_for(name)
  {
    "sunday" => 0,
    "monday" => 1,
    "tuesday" => 2,
    "wednesday" => 3,
    "thursday" => 4,
    "friday" => 5,
    "saturday" => 6
  }.fetch(name.downcase)
end

def in_skip_range?(date, ranges)
  ranges.any? do |range|
    raw_start = range.fetch("start")
    raw_end = range.fetch("end")
    start_date = raw_start.is_a?(Date) ? raw_start : Date.parse(raw_start)
    end_date = raw_end.is_a?(Date) ? raw_end : Date.parse(raw_end)
    date >= start_date && date <= end_date
  end
end

def format_date(date)
  date.strftime("%b %e").strip
end

def format_title(session, slides_dir)
  title = session.fetch("title")
  if session["slides"]
    slides_pptx_base_url = session.fetch("slides_pptx_base_url", nil)
    slides_file = session.fetch("slides")
    if slides_pptx_base_url
      pptx_link = File.join(slides_pptx_base_url, slides_file)
      title = "[#{title}](#{pptx_link})"
    end
  end

  type = session["type"]
  return title if type.nil? || type.downcase == "lecture"

  if type.downcase == "exam"
    return "**#{title}**{: .label .label-exam }"
  end

  label = type.split.map(&:capitalize).join(" ")
  "**#{label}**{: .label .label-purple } #{title}"
end

def format_readings(session)
  readings = session["readings"]
  return nil if readings.nil? || readings.empty?

  "Readings: #{readings.join(", ")}"
end

data = load_data(DATA_PATH)

term = data.fetch("term")
raw_start_date = term.fetch("start_date")
start_date = raw_start_date.is_a?(Date) ? raw_start_date : Date.parse(raw_start_date)
meeting_days = term.fetch("meeting_days").map { |day| wday_for(day) }
assignment_due_day = term["assignment_due_day"]
assignment_due_time = term["assignment_due_time"]
skip_ranges = term.fetch("skip_ranges", [])
skip_dates = (term["skip_dates"] || []).map do |date|
  date.is_a?(Date) ? date : Date.parse(date.to_s)
end
special_dates = (term["special_dates"] || []).each_with_object({}) do |entry, memo|
  raw_date = entry.fetch("date")
  parsed_date = raw_date.is_a?(Date) ? raw_date : Date.parse(raw_date)
  memo[parsed_date] = entry.fetch("label")
end

sessions = data.fetch("sessions")
modules = data.fetch("modules")
slides_dir = data.fetch("slides_dir", "assets/slides")
slides_pptx_base_url = term["slides_pptx_base_url"]

assignment_map = (data["assignments"] || []).each_with_object({}) do |assignment, memo|
  memo[assignment.fetch("id")] = assignment
end

auto_dates = []
cursor = start_date
while auto_dates.length < sessions.length
  if meeting_days.include?(cursor.wday) && !in_skip_range?(cursor, skip_ranges) && !skip_dates.include?(cursor)
    auto_dates << cursor
  end
  cursor += 1
end

auto_index = 0
sessions_with_dates = sessions.map do |session|
  enriched = session.dup
  enriched["slides_pptx_base_url"] = slides_pptx_base_url if slides_pptx_base_url

  if enriched["date"]
    date_value = session.fetch("date")
    parsed_date = date_value.is_a?(Date) ? date_value : Date.parse(date_value)
    enriched.merge("date" => parsed_date)
  else
    date = auto_dates.fetch(auto_index)
    auto_index += 1
    enriched.merge("date" => date)
  end
end

module_index = 0
session_index = 0

modules.each_with_index do |mod, idx|
  count = mod.fetch("sessions")
  slice = sessions_with_dates.slice(session_index, count) || []
  session_index += count

  title = mod.fetch("title")
  slug = mod["slug"] || format("week-%02d", idx + 1)
  path = File.join(MODULES_DIR, "#{slug}.md")

  lines = []
  lines << "---"
  lines << "title: #{title.inspect}"
  lines << "---"
  lines << ""

  slice.each do |session|
    date = session.fetch("date")
    lines << format_date(date)
    lines << ": #{format_title(session, slides_dir)}"

    readings = format_readings(session)
    lines << "  : #{readings}" if readings

    note = special_dates[date]
    lines << "  : #{note}" if note

    (session["assignments_due"] || []).each do |assignment_ref|
      assignment_id = assignment_ref["id"]
      assignment = assignment_map[assignment_id] || {}
      title_text = assignment["title"] || assignment_ref["title"] || "Assignment"
      due_suffix_parts = []
      due_suffix_parts << assignment_due_day if assignment_due_day
      due_suffix_parts << assignment_due_time if assignment_due_time
      due_suffix = due_suffix_parts.empty? ? "" : " (#{due_suffix_parts.join(" ")})"
      label = "**#{title_text} due#{due_suffix}**{: .label .label-red }"
      links = []
      links << "[Download](#{assignment["download_url"]})" if assignment["download_url"]
      links << "[Submit](#{assignment["gradescope_url"]})" if assignment["gradescope_url"]
      label += " " + links.join(" · ") unless links.empty?
      lines << ": #{label}"
    end

    (session["notes"] || []).each do |note|
      lines << "  : #{note}"
    end

    (session["slides_extra"] || []).each do |slide|
      next unless slides_pptx_base_url

      extra_link = File.join(slides_pptx_base_url, slide)
      lines << "  : [PPTX](#{extra_link})"
    end

    lines << ""
  end

  File.write(path, lines.join("\n"))
  module_index += 1
end

warn "Wrote #{module_index} module file(s) to #{MODULES_DIR}."
