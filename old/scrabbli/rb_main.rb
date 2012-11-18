#
#  rb_main.rb
#  scrabbli
#
#  Created by Kristen Mills on 11/12/12.
#  Copyright (c) 2012 Kristen Mills. All rights reserved.
#

# Loading the Cocoa framework. If you need to load more frameworks, you can
# do that here too.
framework 'Cocoa'

# Loading all the Ruby project files.
main = File.basename(__FILE__, File.extname(__FILE__))
dir_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
require 'scrabbli'

# Starting the Cocoa main loop.
NSApplicationMain(0, nil)
