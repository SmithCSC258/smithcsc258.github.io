#!/usr/bin/env ruby
# frozen_string_literal: true

require "csv"
require "yaml"

CSV_PATH = "content/Schedule-CSC210-Topics.csv"
TERM_PATH = "_data/term.yml"
OUT_PATH = "_data/schedule.yml"

abort("Missing CSV: #{CSV_PATH}") unless File.exist?(CSV_PATH)
abort("Missing term config: #{TERM_PATH}") unless File.exist?(TERM_PATH)

term_data = YAML.safe_load(File.read(TERM_PATH), permitted_classes: [Date], aliases: false)
term = term_data.fetch("term")

rows = CSV.read(CSV_PATH, headers: true)
week_key = rows.headers.first
sessions_per_week = term["sessions_per_week"]
week_start = term.fetch("week_start", 1)
slide_sequence = term["slide_sequence"] || []

def yaml_str(value)
  value.to_s.inspect
end

sessions = []
assignments = {}
modules = []
module_counts = {}
module_order = []

day_order = { "Tue" => 1, "Thu" => 2 }
sorted_rows = rows.sort_by do |row|
  week = row[week_key].to_s.strip
  week_num = Integer(week, exception: false) || 0
  day = row["Day"].to_s.strip
  [week_num, day_order.fetch(day, 99)]
end

sorted_rows.each do |row|
  topic = row["Topic"].to_s.strip
  day_raw = row["Day"].to_s.strip
  week = row[week_key].to_s.strip

  next if topic.empty?

  session = {
    "title" => topic,
    "type" => "lecture"
  }

  # meeting days are taken from term.yml to preserve order

  assignment_text = row["Assignment"].to_s.strip
  unless assignment_text.empty?
    parts = assignment_text.split(":", 2)
    aid = if parts.length == 2
            parts.first.strip.downcase
          else
            assignment_text.downcase.tr(" ", "-")
          end
    assignments[aid] ||= assignment_text
    session["assignments_due"] = [{ "id" => aid }]
  end

  midterm_text = row["Midterm"].to_s.strip
  unless midterm_text.empty?
    session["notes"] = ["**#{midterm_text}**{: .label .label-blue }"]
  end

  sessions << session

  unless week.empty?
    module_counts[week] ||= 0
    module_order << week unless module_order.include?(week)
    module_counts[week] += 1
  end
end

slide_index = 0
sessions.each do |session|
  next if slide_sequence.empty?

  entry = slide_sequence[slide_index]
  break if entry.nil?

  if entry.is_a?(Array)
    session["slides"] = entry.first
    extras = entry.drop(1)
    session["slides_extra"] = extras unless extras.empty?
  else
    session["slides"] = entry
  end
  slide_index += 1
end

if sessions_per_week
  total_weeks = (sessions.length.to_f / sessions_per_week).ceil
  total_weeks.times do |i|
    title = format("Week %02d", week_start + i)
    modules << { "title" => title, "sessions" => sessions_per_week }
  end
else
  module_order.each do |week|
    week_num = Integer(week, exception: false)
    title = week_num ? format("Week %02d", week_num) : "Week #{week}"
    modules << { "title" => title, "sessions" => module_counts[week] }
  end
end

lines = []
lines << "term:"
lines << "  name: #{yaml_str(term.fetch('name'))}"
lines << "  start_date: #{term.fetch('start_date')}"
lines << "  end_date: #{term.fetch('end_date')}" if term["end_date"]
lines << "  slides_pptx_base_url: #{yaml_str(term.fetch('slides_pptx_base_url'))}" if term["slides_pptx_base_url"]
lines << "  meeting_days:"
term.fetch("meeting_days").each do |day|
  lines << "    - #{yaml_str(day)}"
end
lines << "  assignment_due_day: #{yaml_str(term.fetch('assignment_due_day'))}"
lines << "  assignment_due_time: #{yaml_str(term.fetch('assignment_due_time'))}"

lines << "  skip_ranges:"
skip_ranges = term.fetch("skip_ranges", [])
if skip_ranges.empty?
  lines << "    []"
else
  skip_ranges.each do |item|
    lines << "    - start: #{item.fetch('start')}"
    lines << "      end: #{item.fetch('end')}"
    lines << "      label: #{yaml_str(item.fetch('label'))}"
  end
end

lines << "  skip_dates:"
skip_dates = term.fetch("skip_dates", [])
if skip_dates.empty?
  lines << "    []"
else
  skip_dates.each { |date| lines << "    - #{date}" }
end

lines << "  special_dates:"
special_dates = term.fetch("special_dates", [])
if special_dates.empty?
  lines << "    []"
else
  special_dates.each do |item|
    lines << "    - date: #{item.fetch('date')}"
    lines << "      label: #{yaml_str(item.fetch('label'))}"
  end
end

lines << ""
lines << "modules:"
modules.each do |mod|
  lines << "  - title: #{yaml_str(mod.fetch('title'))}"
  lines << "    sessions: #{mod.fetch('sessions')}"
end

lines << ""
lines << 'slides_dir: "assets/slides"'
lines << ""
lines << "assignments:"
if assignments.empty?
  lines << "  []"
else
  assignments.each do |aid, title|
    lines << "  - id: #{yaml_str(aid)}"
    lines << "    title: #{yaml_str(title)}"
  end
end

lines << ""
lines << "sessions:"
sessions.each do |session|
  lines << "  -"
  lines << "    title: #{yaml_str(session.fetch('title'))}"
  lines << "    type: #{yaml_str(session.fetch('type'))}"
  if session["assignments_due"]
    lines << "    assignments_due:"
    session["assignments_due"].each do |item|
      lines << "      - id: #{yaml_str(item.fetch('id'))}"
    end
  end
  if session["slides"]
    lines << "    slides: #{yaml_str(session.fetch('slides'))}"
  end
  if session["slides_extra"]
    lines << "    slides_extra:"
    session["slides_extra"].each { |slide| lines << "      - #{yaml_str(slide)}" }
  end
  if session["notes"]
    lines << "    notes:"
    session["notes"].each { |note| lines << "      - #{yaml_str(note)}" }
  end
end

File.write(OUT_PATH, lines.join("\n") + "\n")
puts "Wrote #{OUT_PATH}"
