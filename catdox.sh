#!/bin/bash
# Extract text from Word filename passed in as an argument to STDOUT
# Wraps catdoc and docx2txt
# Requires catdoc, docx2txt, file
# Copyright 2017, University of Pittsburgh
# Written by Clinton Graham for the University Library System
# Licensed under version 2 of the GPL or any later version, or under the Perl artistic license.
CATDOC=/usr/local/bin/catdoc
DOCX2TXT=/usr/local/bin/docx2txt.pl
if [ "$1" = "" ]
then
	>&2 echo 'USAGE '$0' <filename>'
	>&2 echo '  extracts plaintext from Word via catdoc or docx2txt'
	exit  1
fi
if [ ! -e $1 ]
then
	>&2 echo $1 not found
	exit 2
fi
CATDOX_FILE_MIME=`file --brief --mime-type $1`
if [ "$CATDOX_FILE_MIME" != "application/msword" -a "$CATDOX_FILE_MIME" != "application/vnd.ms-office" ]
then
	>&2 echo $1 has an unknown mime signature
	exit 3
fi
CATDOX_FILE_TYPE=`file --brief $1`
if [ "$CATDOX_FILE_TYPE" = "Microsoft Word 2007+" ]
then
	$DOCX2TXT < $1
else
	$CATDOC $1
fi
