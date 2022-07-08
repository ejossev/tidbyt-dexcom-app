#!/bin/bash

SCRIPTDIR=/var/dexcom/dexcom-tidbyt
PIXLET=/usr/local/bin/pixlet

$PIXLET render $SCRIPTDIR/dexcom.star
$PIXLET push strenuously-fast-approving-redpoll-59b $SCRIPTDIR/dexcom.webp -t eyJhbGciOiJFUzI1NiIsImtpZCI6IjY1YzFhMmUzNzJjZjljMTQ1MTQyNzk5ODZhMzYyNmQ1Y2QzNTI0N2IiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJodHRwczovL2FwaS50aWRieXQuY29tIiwiZXhwIjoxNjgwMDk0NDA3LCJpYXQiOjE2NDg1NTg0MDcsImlzcyI6Imh0dHBzOi8vYXBpLnRpZGJ5dC5jb20iLCJzdWIiOiJyNU5VNEJjYUMzZVVJZlZTeWxWQlVVUGFYeGwyIiwic2NvcGUiOiJkZXZpY2UiLCJkZXZpY2UiOiJzdHJlbnVvdXNseS1mYXN0LWFwcHJvdmluZy1yZWRwb2xsLTU5YiJ9.eQj98uw_DVNGpuAIg04GNkvMzeLd-M_YtIl-oWrqv6ipboMtxDtc-rxaD0G_sIv0cNUUtxw87UpQx0O4o2ZCjQ -i Dexcom

