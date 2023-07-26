#!/bin/sh


# <- {"execute":"guest-ping"}
# -> {"return": {}}

# <- {"execute": "guest-info"}
# -> {"return": {"version": "1.0"}}


socat unix-connect:/tmp/qga.sock stdout
