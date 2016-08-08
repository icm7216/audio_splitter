#!/usr/bin/env ruby
# encoding: utf-8

# ////////////////////////////////////////////
# input file name
input_file = "Full_Album.wav"

# metadata
artist = "Artist Name"
album = "Album Name"

track_title = [
 "track title 1",
 "track title 2",
 "track title 3",
 "track title 4"
]

# split the track of a file at a specified time.
# time is the elapsed time from "00:00:00".
track_time = [
 "00:09:16",
 "00:20:33",
 "00:31:40",
 "00:41:20"
]
# ////////////////////////////////////////////


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

