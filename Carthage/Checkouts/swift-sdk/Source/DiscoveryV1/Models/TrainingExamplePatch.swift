/**
 * Copyright IBM Corporation 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/** TrainingExamplePatch. */
internal struct TrainingExamplePatch: Encodable {

    public var crossReference: String?

    public var relevance: Int?

    // Map each property name to the key that shall be used for encoding/decoding.
    private enum CodingKeys: String, CodingKey {
        case crossReference = "cross_reference"
        case relevance = "relevance"
    }

    /**
     Initialize a `TrainingExamplePatch` with member variables.

     - parameter crossReference:
     - parameter relevance:

     - returns: An initialized `TrainingExamplePatch`.
    */
    public init(crossReference: String? = nil, relevance: Int? = nil) {
        self.crossReference = crossReference
        self.relevance = relevance
    }

}
