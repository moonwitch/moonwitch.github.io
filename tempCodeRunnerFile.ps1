$IronEnv = @{
  servers = @{
    main = @(
      "DRONVQAEP"
    )
    db   = @(
      "DRONVQDBIP"
    )
    tce  = @(
      "DRONVQTCEP01"
      "DRONVQTCEP02"
      "DRONVQTCEP03"
      "DRONVQTCEP04"
      "DRONVQTCEP05"
    )
  }
}

$EnvIndex =Read-Host "Which environment are we doing? [A]cceptance, [T]est or [P]roduction"

$EnvSelector = switch ($EnvIndex) {
  A { Write-Output $EnvIndex }
  T { Write-Output $EnvIndex }
  P { Write-Output $EnvIndex }
}

foreach ($server in $IronEnv.Keys) {
  Write-Output $server
}