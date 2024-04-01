@echo off


::===============================================================================================
::
::  A script to download videos or playlists, and attach "playlist index" to the filename of each video.
::  Visit https://github.com/GhostasDead/DownVidas for more info.
::
::  Done Bit By Bit By: Ahmad SalahiEh (https://t.me/GhostasDead)
::  Thanks To All The People Who Contributed To youtube-dl, yt-dlp and ytarchive Over The Years!
::
::===============================================================================================



::=====================================================================================================

set "dv_title=DownVidas"
title %dv_title%

:Window-Persist:
:: A work-around to persist window, and make 'exit' command close window even if end of file not reached.
for %%x in (%cmdcmdline%) do if /i "%%~x"=="/c" (cmd /k "%~dpf0" & set isParent=1)
if defined isParent (exit)

:Initialize:
if defined first_run goto Check-Dependencies
:: Append script to PATH variable during session to execute it anywhere.
:: Scirpt downloads videos in current working directory, so you can download anywhere that way.
set path=%~dp0;%path%

:: Set macro for easy re-execution
doskey dv=%~nx0

::=====================================================================================================

:Check-Dependencies:
echo [0m
title %dv_title% [Checking Dependencies...]
where /q yt-dlp && where /q ffmpeg && where /q ffprobe

:: Halt if dependencies not found
if %errorlevel% neq 0 (
  title %dv_title% [Dependencies Required]
  echo Make sure dependencies are in the same folder or in PATH then try again.
  echo You can download them from here :
  echo[
  echo https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe
  echo[
  echo https://github.com/yt-dlp/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip
  echo[
  pause
  exit
)

::=====================================================================================================

:info:
if defined first_run goto URL-Input
echo [90mControls: [36mCtrl+C[90m to halt. While downloading: Press [36mPAUSE/BREAK[90m to pause. Press [36many other key[90m to resume.
echo           [36mUP/Down[90m Arrow Keys to cycle through commands history. (e.g. macro, URL, quality)
echo Macro (alias to re-execute script): [36mdv[0m
echo ------------------------------------------------------------
echo[

set first_run=1

::=====================================================================================================

:URL-Input:

:: Initializing variables to avoid using instances of previous sessions.
set "url="
title %dv_title% [Input Link]
:: Pipe commands to recolor text to white when termination with Ctrl-C
set /p url=Enter Video/Playlist URL(s): [95m|| (echo [0m & title %dv_title% & goto END)
echo [0m


:Quality-Select

echo Available quality Options: audio_only, 144p, 240p, 360p, 480p, 720p, 1080p, best
set "q_alias="
title %dv_title% [Input Quality]
set /p q_alias=Enter Desired Video Quality: [95m|| (echo [0m & title %dv_title% & goto END)

::=====================================================================================================

:Quality-Aliases:

set "quality="
if /i "%q_alias%" equ "audio-only" (set "quality=audio"
) else if /i "%q_alias%" equ "audio_only" (set "quality=audio"
) else if /i "%q_alias%" equ "audio" (set "quality=audio"
) else if /i "%q_alias%" equ "aud" (set "quality=audio"
) else if /i "%q_alias%" equ "a" (set "quality=audio"
) else if /i "%q_alias%" equ "sound" (set "quality=audio"
) else if /i "%q_alias%" equ "music" (set "quality=audio"

) else if /i "%q_alias%" equ "144p" (set "quality=144"
) else if /i "%q_alias%" equ "144" (set "quality=144"
) else if /i "%q_alias%" equ "worst" (set "quality=144"
) else if /i "%q_alias%" equ "w" (set "quality=144"

) else if /i "%q_alias%" equ "240p" (set "quality=240"
) else if /i "%q_alias%" equ "240" (set "quality=240"

) else if /i "%q_alias%" equ "360p" (set "quality=360"
) else if /i "%q_alias%" equ "360" (set "quality=360"

) else if /i "%q_alias%" equ "480p" (set "quality=480"
) else if /i "%q_alias%" equ "480" (set "quality=480"
) else if /i "%q_alias%" equ "sd" (set "quality=480"

) else if /i "%q_alias%" equ "720p" (set "quality=720"
) else if /i "%q_alias%" equ "720" (set "quality=720"
) else if /i "%q_alias%" equ "HD" (set "quality=720"

) else if /i "%q_alias%" equ "1080p" (set "quality=1080"
) else if /i "%q_alias%" equ "1080" (set "quality=1080"
) else if /i "%q_alias%" equ "FullHD" (set "quality=1080"
) else if /i "%q_alias%" equ "FHD" (set "quality=1080"

) else if /i "%q_alias%" equ "best" (set "quality=best"
) else if /i "%q_alias%" equ "bes" (set "quality=best"
) else if /i "%q_alias%" equ "b" (set "quality=best"

) else (echo [31mERROR:[0m Wrong quality argument. & CHOICE /c YN /m "Re-enter quality [(Y)es/(N)o]?" /n
)
if %errorlevel% EQU 2 (
  echo ------------------------------------------------------------
  echo[
  goto URL-Input
)
if %errorlevel% EQU 1 (echo[ & goto Quality-Select)
if not defined quality (title %dv_title% & goto END)

echo [0m------------------------------------------------------------

::=====================================================================================================

:Format-Select:

if %quality% equ audio (
  set format="258/256/140/251/ba"                   & set sort="acodec:m4a,aext:mp4a,proto" 
  set "quality=abr&{}k"
) else ( 
    if %quality% equ 144 (
      set format="91/160+140/bv*+ba/b*"             & set sort="res:144,fps,codec:avc:m4a,ext:mp4:mp4a,proto"
  ) else if %quality% equ 240 (
      set format="92/133+140/bv*+ba/b*"             & set sort="res:240,fps,codec:avc:m4a,ext:mp4:mp4a,proto"
  ) else if %quality% equ 360 (
      set format="18/93/134+140/bv*+ba/b*"          & set sort="res:360,fps,codec:avc:m4a,ext:mp4:mp4a,proto"
  ) else if %quality% equ 480 (
      set format="94/135+140/bv*+ba/b*"             & set sort="res:480,fps,codec:avc:m4a,ext:mp4:mp4a,proto"
  ) else if %quality% equ 720 (
      set format="22/300/298+140/136+140/bv*+ba/b*" & set sort="res:720,fps,codec:avc:m4a,ext:mp4:mp4a,proto"
  ) else if %quality% equ 1080 (
      set format="301/299+140/137+140/bv*+ba/b*"    & set sort="res:1080,fps,codec:avc:m4a,ext:mp4:mp4a,proto"
  ) else if %quality% equ best (
      :: Prefer AV1 over other vcodecs
      set format="bv*+ba/b*" & set sort="res,fps,codec:av01,proto"
  )
  set "quality=resolution"
)

::=====================================================================================================

:List-Videos:

echo[
title %dv_title% [Extracting Link Information...]

setlocal EnableDelayedExpansion

set listinfo_file=DV-listInfo.txt
where /q %listinfo_file% && del %listinfo_file%

yt-dlp^
 --simulate --write-playlist-metafiles --write-description --skip-download --flat-playlist --no-playlist ^
 --no-warnings -q^
 --extractor-retries 1^
 --replace-in-metadata title "[\U00010000-\U0010ffff]" ""^
 --print "video:     %%(playlist_index&{} - |)s%%(title).200B  [1m%%(duration_string)s   %%(uploader_id)s[0m"^
 --print-to-file "video:%%(playlist_index&{} - |)s%%(title).200B  %%(duration_string)s   %%(uploader_id)s" %listinfo_file%^
 --print "playlist:"^
 --print "playlist:Videos of Playlist [95m%%(title&{} |)s[0mTo Be Downloaded ^"^
 --print "playlist:"^
 --print "playlist:(Check [1m%listinfo_file%[0m if characters above not displayed corretly.)"^
 !url!
:: Note: Displaying size requires info extraction for each video, which takes a lot of time for large playlists.
::       To display size regradless, remove --flat-playlist argument and replace first --print line with:
::       -f %format -S %sort% --print "video:     %%(playlist_index&{} - |)s%%(title).200B  [1m%%(duration_string)s  %%(filesize,filesize_approx|)#.2DB  %%(uploader_id)s[0m"^

:: Don't download if listing errored
if %errorlevel% neq 0 (
  echo[ & echo [31mERROR:[0m Check Your Internet Connection, or if URL Needs Correction, Then Try Again.
  title %dv_title% [Internet or Link Issue]
  goto END
)
title %dv_title% [Preparing Download...]
echo[
echo ------------------------------------------------------------

::=====================================================================================================

:Download-Videos:

yt-dlp^
 --format %format% -S %sort%^
 --retries 5 --extractor-retries 1 --fragment-retries 5 --abort-on-error --abort-on-unavailable-fragment -N 4^
 --no-mtime  --embed-metadata --embed-thumbnail --embed-subs --sub-langs "en.*,ja.*,ar.*,.*-orig",-live_chat^
 --cookies cookies.txt --live-from-start --no-warnings -q --progress --no-playlist^
 --replace-in-metadata title "[\U00010000-\U0010ffff]" ""^
 -o "%%(playlist|^!VidDownloads)s/%%(playlist_index&{} - |)s%%(title).200B (%%(height&{}p|audio)s).%%(ext)s"^
 --print "pre_process:"^
 --exec "pre_process:title %dv_title% [Getting Info...]"^
 --print "video:[1m%%(playlist|^!VidDownloads)s/[0m%%(playlist_index&{} - |)s%%(title).200B (%%(height&{}p|audio)s).%%(ext)s"^
 --print "video:[90m VideoID:%%(id)s, FormatID:%%(format_id)s[0m"^
 --print "video: Quality:[1m%%(%quality%)s[0m, FPS:[1m%%(fps)s[0m, Duration:[1m%%(duration_string)s[0m, Size:[1m%%(filesize,filesize_approx|0)#.2DB[0m, Upload Date:[1m%%(release_date>%%Y-%%m-%%d,upload_date>%%Y-%%m-%%d)s %%(release_timestamp>%%H:%%M:%%S,timestamp>%%H:%%M:%%S|)s-UTC[0m"^
 --print "video:"^
 --exec "before_dl:title %dv_title% [Downloading...]"^
 --exec "post_process:title %dv_title% [Media Being Processed...]"^
 --print "after_video:------------------------------------------------------------ [32mVideos Downloaded: %%(autonumber)d[0m"^
 --exec "after_video:title %dv_title% [A Download Has Finished]"^
 --exec "playlist:if !errorlevel! equ 1 (echo --------------------- [33mEnd of Playlist[0m ---------------------) else (echo --------------------- [32mEnd Of Playlist[0m ----------------------)"^
 --exec "playlist:title %dv_title% [Playlist Download Finished] & pause"^
 !url!

if %errorlevel% equ 0 (
  title %dv_title% [Download Finished]
  echo [92mDownload Finished.[0m
)

::=====================================================================================================

:END:

echo[
echo Type [36mdv[0m and hit Enter for another download.