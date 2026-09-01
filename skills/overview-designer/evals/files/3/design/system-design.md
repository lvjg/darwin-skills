# Configuration Compilation Controller

## Initial direction

Introduce a controller that polls compiled and desired revisions every second. Treat revision lag as the error term and use proportional, integral and derivative gains to adjust worker concurrency. Persist the accumulated error and controller output in a new controller database so processing converges on the desired revision.
