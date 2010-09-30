"Run the GitFS Tests"
HDChangeReport runPackages: #('Zinc-HTTP' 'Zinc-Tests').
HDCoverageReport runPackages: #('Zinc-Tests').
HDLintReport runPackages: #('Zinc-HTTP').
	

