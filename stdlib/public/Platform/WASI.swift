//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_exported import SwiftWASI // Clang module

public let MAP_FAILED: UnsafeMutableRawPointer! = UnsafeMutableRawPointer(bitPattern: -1)

// WebAssembly's error.h uses a macro that Swift can't import.
public let EINTR:Int32 = 27
public let EINVAL:Int32 = 28
