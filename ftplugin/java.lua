--- java.lua
-- Configuration for java support provided by jdtls.
---

-- TODO: update this to current configuration, untested yet
local config = {
	cmd = {
		"/usr/lib/jvm/java-20-openjdk/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		os.getenv("JDTLS_ECLIPSE_EQUINOX_LAUNCHER_PLUGIN"),
		"-configuration",
		os.getenv("JDTLS_SYSTEM_CONFIGURATION"),
		"-data",
		os.getenv("JDTLS_WORKSPACE"),
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk/",
					},
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk/",
					},
					{
						name = "JavaSE-20",
						path = "/usr/lib/jvm/java-20-openjdk/",
					},
				},
			},
		},
	},
	init_options = {
		bundles = {},
	},
}

-- nvim-dap integration
local bundles = {
	vim.fn.glob(os.getenv("JAVA_DEBUG_PLUGIN") .. "com.microsoft.java.debug.plugin-*.jar", 1),
}

-- support for running tests
vim.list_extend(bundles, vim.split(vim.fn.glob(os.getenv("JAVA_TEST_RUNNER_PLUGIN") .. "*.jar", 1), "\n"))
config["init_options"] = {
	bundles = bundles,
}

require("jdtls").start_or_attach(config)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
