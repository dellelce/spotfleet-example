#!/bin/bash
#
# Download latest terraform binary available from Official Terraform website
#

## FUNCTIONS ##

make_download_url()
{
  echo in progress
}

get_current_version()
{
  wget -q -O - "$version_url" |
  awk '

BEGIN { version = ""; state = 0; }

state == 0 && $0 ~ /[0-9]+\.[0-9]+\.[0-9]+/ \
 {
   gsub(/[()<>]/, " ");

   split($0, ver_a, " ");
   a_len = length(ver_a)

   for (i = 0; i <= a_len; i=i+1)
   {
     if (state == 0 && ver_a[i] ~ /style_version/) { state = 1; continue; }

     if (state == 1 && ver_a[i] ~ /[0-9]+\.[0-9]+\.[0-9]+/ && ver_a[i] !~ /^href/)
     {
       version=ver_a[i]
       state = 2 # state = 2: completed version search
     }
   }

 }

END { if (state == 2) { print version; }; }
' 

}

## ENV ##

version_url="https://www.terraform.io/downloads"

## MAIN ##

get_current_version

## EOF ##
