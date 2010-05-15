"Run the Pier Tests"
HDTestReport runPackages: #('Pier-Tests' 'Pier-Blog' 'Pier-Security' 'Pier-Squeak-Persistency').
HDLintReport runPackages: #('Pier-Model' 'Pier-Seaside' 'Pier-Blog' 'Pier-Security').
