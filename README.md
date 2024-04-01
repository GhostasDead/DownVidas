# DownVidas
Video/Audio Downloading script that numerates playlist media files, in a simple and user-friendly manner.


## Download

### All in one package
* [DownVidas.zip](https://github.com/GhostasDead/DownVidas/releases/latest/download/DownVidas.zip) containts the script and latest builds of required dependencies (yt-dlp.exe, ffmpeg.exe and ffprobe.exe).

### Seperately
* [DownVidas.cmd](https://github.com/GhostasDead/DownVidas/raw/main/DownVidas.cmd) - The actual script that you should run.

* [yt-dlp](https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe) - (dependency) The popular CLI Porgram, known for downloading media from almost every streaming service and social media site.

* [FFMpeg and FFProbe](https://github.com/yt-dlp/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip) - (dependency, extract only ffmpeg.exe and ffprobe.exe from archive) yt-dlp builds of FFMpeg, required for media post-processing and merging tasks.

Make sure to download and put dependencies in the same folder as the script, or in `PATH`.
Script won't run without dependencies.

#### Script folder should containt:
`Downvid.cmd` (run this)

`FFmpeg.exe`

`FFProbe.exe`

`yt-dlp.exe`


## Usage
1. Run DownVidas.cmd
1. Enter playlist or channel or video URL(s). (Youtube video IDs are also acceptable).
1. Enter desired quality from the listed options.
1. Let script process the link then it will start downloading.
1. Downloaded files are stored in a folder named after their corresponding playlist name or in `!VidDownloads`.


## Controls (Globally available in CMD already):
* `PAUSE` key: while downloading to pause temporarily.
* Any other key: to resume (if paused).
* `Ctrl+C` (twice): to interrupt/quit/halt/stop it... get some /help.


## Downloading Features
* Download All kinds of videos and playlists.
* Support multiple URLs (seperated by spaces).
* Support YouTube and other websites, like Twitch, Facebook, Reddit, Twitter, (etc.)[https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md]
* Attach "playlist index" to the filename of each video, but only if playlist URL.
* Remove emojis from filenames for compatiblity with certain file systems.
* Embed English, Arabic and Japanese subtitles into video file to avoid clutter.
* Embed also thumbnails and metadata for maximum experinece.
* Try to download closest quality to the one selected, if exact quality not available.
* Prefer `AVC/H264` quality over `VP9` and `AV01`, to be compatible with common devices.
* List all playlist/channel videos' `titles` with their `duration` and `uploader_id` before download.
* Detailed information about the current download.
* Prefer download over `HTTPS` protcol. (`M3U8` protocol takes more bandwidth and time to post-process.)
* Prefer more processed Youtube `format_id`s (like `18` (for 360p) and `22` (for 720p)) that have better 'quality to size' ratio.
* Show the number of successfully downloaded videos after each successful download.
* Colored text with seperators to indicate 'end of playlist'
* Append `quality` to the end of `filename`, to avoid resuming over partialy downloaded files with another resolution.
* Download current `live streams` from the start.


## Console Features
* Window persist (prevent closing console window when done exectuing or `Ctrl+C`).
* Script added to `PATH` during session to execute anywhere.
* Informative console window titles.
* Macro/Alias `dv` for easy execution after exiting.
* Check dependencies before prompting the user and waste their time.
* Show controls to pause, resume or halt, for people not familiar with CLI.
* Colored input to make typed text distict from other texts
* Aliases for different quality options, and re-prompt for incorrect choices.
* Handle the pressing of `Ctrl+C` twice, so it doesn't continue executing the script.
* Consider `ERRORLEVEL` vaules throughout the script, for efficiency.
* Add seperators and empty lines, to make output more human readable.
* Not using hardcoded paths, makes renaming/moving script file not disastrous (Some features rely on that path).
* Save currently downloaded video titles to a file `DV-listInfo.txt`, since dedault console font doesn't support certain langs and emojis.


## Notes
I know CLI might still be a scary place for a lot of people, so tried to make this script as user-friendly and fool-proof as possible.

* Requirements: (again) Make sure yt-dlp, ffmpeg and ffprobe exist in the same folder along with DownVidas, or in PATH before running the script.
* Media title characters may appear weird on the console but they are processed and saved correctly (check DV-listInfo.txt for correct filename).
* Editing video order in a playlist will affect its index number accordingly.
* yt-dlp usually resumes download if temporay files (.part) not moved or altered.


## TODO
* Replicate script in `.sh` to support GNU/Linux.
* Check if link is a video, a playlist or a channel and change list/download logic accordingly.
* Provide another variant (DownVidaSize.cmd?) to prompt user if they would like for the script to extract `filesize` of each video in the playlist along with title, duration and uploader_id (drawback is it takes more time, about 5 seconds for each video).
* Let the user choose in what order should the playlist download, and save their choice (to continue with the same choice if download had interrupted).
* Append smallest dimension to video filename (instead of height).
* Find a good way to implement `--download-archive`

**Suggestions and Pull Requests are also welcome**


## Credits
Thanks To All The People In The Community Who Contributed To [youtube-dl](https://github.com/ytdl-org/youtube-dl), [yt-dlp](https://github.com/yt-dlp/yt-dlp), [ytarchive](https://github.com/Kethsar/ytarchive) and [FFMpeg](https://ffmpeg.org/) Over The Years!
* [Seal Downloader](https://github.com/JunkFood02/Seal) - MVP of all downloaders that "just werks" on android, inspired me to invest more in yt-dlp.
* [SS64](https://ss64.com/nt) - Great reference for Windows CMD commands and Batch file handling.
* holoPi`[REDACTED]` - Providing templates and work-arounds to bypass and archive.
* Ne`[REDACTED]` - A certain vTuber that got me into this whole stream/VOD download thing. Also, their timezone helped me correct actual stream date (Rabbit hole worth it in the end?)
* `[REDACTED]` - A classmate of mine who asked if I know a program for this task. (That made me motivated all of a sudden!)