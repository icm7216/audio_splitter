#!/usr/bin/env ruby
# encoding: utf-8


# Split the audio file at a specified time.
# Add metadata, convert to MP3.

require 'yaml'
meta_file = "audio_splitter.yaml"

# read metadata from YAML
meta = YAML.load_file(meta_file)
 
# set metadata item
input_file = "#{meta[:file]}"
artist = "#{meta[:artist]}"
album = "#{meta[:album]}"
track_title = []
track_time = []

meta[:track].each do |track|
  track_title << "#{track[:title]}"
  track_time << "#{track[:time]}"
end


# processing for ffmpeg metadata
seek_pos = "00:00:00"

track_title.each_with_index do |title, i|
  track_number = sprintf("%02d", i + 1).to_s
  output_name = %Q[#{track_number}_#{title.gsub(/ /, '_')}]
  next_pos = track_time[i]

  cmd = %Q[ffmpeg -i #{input_file} -ss "#{seek_pos}" -to "#{next_pos}"]
  cmd << %Q[ -metadata album="#{album}"]
  cmd << %Q[ -metadata artist="#{artist}"]
  cmd << %Q[ -metadata title="#{title}"]
  cmd << %Q[ -metadata track="#{i + 1}/#{track_title.size}"]
  cmd << %Q[ -id3v2_version 3 -ab 128k #{output_name}.mp3]
 
  #puts cmd
  system(cmd)
  
  seek_pos = next_pos
end

