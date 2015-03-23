# == Type: mdadm::array
#
# This defined type will manage an mdadm array. This is basically a wrapper
# around the custom mdadm type. The purpose of this define is really to ensure
# that the mdadm class is present.
#
# All parameter validation happens in the custom type.

# === Parameters
#
# [*ensure*]
#   Valid values are 'created', 'assembled', 'stopped', 'absent'. Required.
#
# [*level*]
#   The raid level, 0,1,4,5,6 linear, multipath and synonyms. Required.
#
# [*devices*]
#   An array of underlying devices for the raid. Required.
#
# [*active_devices*]
#   An optional value used to specify the number of devices that are active.
#   Cannot be more than the number of devices. Defaults to all devices.
#
# [*spare_devices*]
#   An optional value used to specify the number of spare devices.
#
# [*chunk*]
#   Optionally specify the chunksize in kibibytes.
#
# [*parity*]
#   The raid parity. Only applicable to raid5/6  Valid values are
#   'left-symmetric', 'right-symmetric', 'left-asymmetric', 'right-asymmetric'.
#
# [*bitmap*]
#   Create a bitmap for the array with the given filename.
#
# [*metadata*]
#   Declare the style of superblock (raid metadata) to be used. The default is
#   0.90 for created, and to guess for other operations.
#
# [*force*]
#   Whether to force the action. Useful for when the underlying devices had
#   previously been created on an array. Can be destructive if the underlying
#   devices were part of different arrays. Use with caution. Default is false.
#
# [*generate_conf*]
#   Boolean. Whether to generate the mdadm.conf file. Default is true.
#
# [*update_initramfs*]
#   Boolean. Whether to update initrd with the new device. Default is true.
#
# === Usage
#
# mdadm::array { '/dev/md1':
#   ensure => 'created',
#   level  => '1',
#   devices => ['/dev/sdb', '/dev/sdc']
# }
#
define mdadm::array (
  $ensure,
  $level,
  $devices,
  $active_devices = undef,
  $spare_devices = undef,
  $chunk = undef,
  $options = undef,
  $parity = undef,
  $bitmap = undef,
  $metadata = undef,
  $force = undef,
  $generate_conf = undef,
  $update_initramfs = undef,
) {
  include mdadm

  mdadm { $name :
    ensure           => $ensure,
    level            => $level,
    devices          => $devices,
    active_devices   => $active_devices,
    spare_devices    => $spare_devices,
    chunk            => $chunk,
    options          => $options,
    parity           => $parity,
    bitmap           => $bitmap,
    metadata         => $metadata,
    force            => $force,
    generate_conf    => $generate_conf,
    update_initramfs => $update_initramfs,
  }
}
