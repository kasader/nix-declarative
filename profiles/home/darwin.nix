{ ... }:
{
  # macOS-only configuration. Only Darwin hosts import this profile, so nothing
  # here needs an `isDarwin` guard — Linux hosts never evaluate it (which also
  # keeps Darwin-only packages like `mkalias` off Linux).
  imports = [ ../../modules/home/darwin ];
}
