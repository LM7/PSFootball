//
//  Config.swift
//  PSFootball
//
//  Created by Lorenzo on 06/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation

#if PRODUZIONE
let environment: EnvironmentType = .prod

#elseif COLLAUDO
let environment: EnvironmentType = .coll

#else
let environment: EnvironmentType = .test

#endif





