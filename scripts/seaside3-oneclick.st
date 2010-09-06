(ToolSet browse: WACounter selector: #renderContentOn:)
	right: World width - 10;
	bottom: World height - 40.
!
(Workspace new
	contents: (String streamContents: [ :stream |
		stream
			nextPutAll: 'Welcome to Seaside ';
			nextPutAll: GRPlatform current seasideVersion greaseString;
			nextPut: $.;
			cr; cr;
			nextPutAll: 'Seaside is already running on port 8080. To get started, simply use your browser to open http://localhost:8080/ and take a look at the examples and documentation listed there.';
			cr; cr;
			nextPutAll: 'You can start and stop the server (and change the port) using the new Seaside Control Panel.' ]);
	openLabel: 'Seaside ', GRPlatform current seasideVersion greaseString;
	topView)
		width: 450;
		height: 210;
		top: 10;
		right: World width - 10.