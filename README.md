Spider
======

[![](https://github.com/AjxLab/Dajare-Extractor/workflows/build/badge.svg)](https://github.com/AjxLab/Dajare-Extractor/actions)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

Spider of this [ダジャレステーション](https://dajare.jp/).


## Description
This spider fetchs the following items.
* dajare text
* dajare score
* dajare author


## Requirements
* macOS
* Ruby 2.7
* SQLite3


## Usage
### Start Crawling
```sh
$ bundle exec ruby spider.rb
```
### Setup Gmail
```sh
$ bundle exec rake setup:gmail
Gmail Address：your.address@gmail.com     # Enter your gmail address
Application Password：**********  # Enter your application password
```
### Database
#### Migratiton
```sh
$ bundle exec rake db:migrate
```
#### Clear DB
```sh
$ bundle exec rake db:clear
```
#### Clear Table
```sh
$ bundle exec rake db:clear_<tablename>
```
### Clear Log
```sh
$ bundle exec rake log:clear
```

## Installation
1. Clone this repo
```sh
$ git clone <this repo>
$ cd <this repo>
```
2. Build gems
```sh
$ bundle install
```


## References
<div><a href="https://dajare.jp/" target="_blank"><img src="https://dajare.jp/library/image/Banner/Advertisement/Dajare180x28.png" alt="ダジャレ（だじゃれ）ステーション" border="0" vspace="8" onmouseover="this.src=this.src.replace('png','gif');" onmouseout="this.src=this.src.replace('gif','png');" /></a></div>

## Author
* Tatsuya Abe
* abe12@mccc.jp
