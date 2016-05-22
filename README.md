## ⌚️WatchDVB

An iOS and Watch app showing current public transport departure times in Dresden, Germany.

Still WIP, screenshots coming soon.

Planned features:

 - Watch complication showing the next departure from a chosen stop
 - Support for choosing more than one stop, the nearest one is the displayed one
 - Support for specifying which direction of departures
 - Support for limiting which transport methods to use (e.g. Bus or Tram, etc.)
 - Support a custom offset time (e.g. time to walk to the stop)
 - Show the icon of the transport mode in the complication

Most of the features listed above are supported directly by the underlying [DVB](https://github.com/kiliankoe/DVB) framework. Settings will likely only be set in the companion iOS app.

If possible it might also be nice to basically build the Watch functionality as a Today extension for those not using a watch.

