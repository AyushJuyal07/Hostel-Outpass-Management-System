enum OfficerRole { warden, guard }

enum PassType { day, night }

enum PassStatus {
  /// Pass is created but not verified
  generated,

  /// Verified that student has gone out
  opened,

  /// Verified that student has returned back
  closed,
}
