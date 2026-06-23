package buildmeta

// Version, Commit, and BuildTime are injected at link time via -ldflags.
var (
	Version   = "0.0.0-dev"
	Commit    = "unknown"
	BuildTime = "unknown"
)

// Info returns build metadata as a map for JSON APIs.
func Info() map[string]string {
	return map[string]string{
		"version":    Version,
		"commit":     Commit,
		"build_time": BuildTime,
	}
}
