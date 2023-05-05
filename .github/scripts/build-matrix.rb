require "json"
require "optparse"

BASE_MATRIX_ENTRIES = [
  {
    "build_os": "ubuntu-18.04",
    "agent_query": "ubuntu-20.04",
    "target": "ubuntu18.04_x86_64",
#   "container": "ghcr.io/swiftwasm/swift-ci:main-ubuntu-18.04",
    "container": "ghcr.io/swiftwasm/swift-ci@sha256:e38db2e47e9b4a9207276fd3061748a719901884a6fa44562abb47d196534864",
    "run_stdlib_test": true,
    "run_full_test": false,
    "run_e2e_test": true,
    "build_hello_wasm": true,
    "clean_build_dir": false,
    "free_disk_space": true
  },
  {
    "build_os": "ubuntu-20.04",
    "agent_query": "ubuntu-20.04",
    "target": "ubuntu20.04_x86_64",
#   "container": "ghcr.io/swiftwasm/swift-ci:main-ubuntu-20.04",
    "container": "ghcr.io/swiftwasm/swift-ci@sha256:5e135cc954d23467cbd3bc54583d1bd870d7e268b339ef8638f9a38b74cb8503",
    "run_stdlib_test": true,
    "run_full_test": false,
    "run_e2e_test": true,
    "build_hello_wasm": true,
    "clean_build_dir": false,
    "free_disk_space": true
  },
  {
    "build_os": "ubuntu-22.04",
    "agent_query": "ubuntu-22.04",
    "target": "ubuntu22.04_x86_64",
#   "container": "ghcr.io/swiftwasm/swift-ci:main-ubuntu-22.04",
    "container": "ghcr.io/swiftwasm/swift-ci@sha256:8b667f18c8cfc34b9823bfe797fb4a279611f9a61732d5e7f6e5304c8c43326e",
    "run_stdlib_test": true,
    "run_full_test": false,
    "run_e2e_test": true,
    "build_hello_wasm": true,
    "clean_build_dir": false,
    "free_disk_space": true
  },
  {
    "build_os": "amazon-linux-2",
    "agent_query": "ubuntu-22.04",
    "target": "amazonlinux2_x86_64",
#   "container": "ghcr.io/swiftwasm/swift-ci:main-amazon-linux-2",
    "container": "ghcr.io/swiftwasm/swift-ci@sha256:4bf1e80ea3757a6cb0c3ebf7ed9423971c5ecb9ce8162a46487a1cb0398b4e69",
    "run_stdlib_test": false,
    "run_full_test": false,
    "run_e2e_test": false,
    "build_hello_wasm": true,
    "clean_build_dir": false,
    "free_disk_space": true
  },
  {
    "build_os": "macos-11",
    "agent_query": "macos-11",
    "target": "macos_x86_64",
    "run_stdlib_test": false,
    "run_full_test": false,
    "run_e2e_test": false,
    "build_hello_wasm": false,
    "clean_build_dir": false
  },
  {
    "build_os": "macos-11",
    "agent_query": ["self-hosted", "macOS", "ARM64"],
    "target": "macos_arm64",
    "run_stdlib_test": false,
    "run_full_test": false,
    "run_e2e_test": false,
    "build_hello_wasm": true,
    "clean_build_dir": true
  }
]

def main
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: build-matrix.rb [options]"
    opts.on("--runner [JSON FILE]", "Path to runner data file") do |v|
      options[:runner] = v
    end
  end.parse!

  matrix_entries = BASE_MATRIX_ENTRIES.dup
  if options[:runner]
    runner = JSON.parse(File.read(options[:runner]))
    if label = runner["outputs"]["ubuntu20_04_aarch64-label"]
      matrix_entries << {
        "build_os": "ubuntu-20.04",
        "agent_query": label,
        "target": "ubuntu20.04_aarch64",
#       "container": "ghcr.io/swiftwasm/swift-ci:main-ubuntu-20.04",
        "container": "ghcr.io/swiftwasm/swift-ci@sha256:5e135cc954d23467cbd3bc54583d1bd870d7e268b339ef8638f9a38b74cb8503",
        "run_stdlib_test": false,
        "run_full_test": false,
        "run_e2e_test": false,
        "build_hello_wasm": true,
        "clean_build_dir": false
      }
    end
  end

  print JSON.generate(matrix_entries)
end

if $0 == __FILE__
  main
end
