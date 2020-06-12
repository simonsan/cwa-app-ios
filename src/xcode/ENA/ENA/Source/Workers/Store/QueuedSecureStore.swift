//
// Corona-Warn-App
//
// SAP SE and all other contributors
// copyright owners license this file to you under the Apache
// License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import Foundation

/// The `SecureStore` class implements the `Store` protocol that defines all required storage attributes.
/// It uses an SQLite Database that still needs to be encrypted
final class QueuedSecureStore: QueuedStore {
	private let directoryURL: URL
	private let kvStore: SQLiteKeyValueStore
	private let queue = DispatchQueue(label: "com.sap.securestore")

	init(at directoryURL: URL, key: String) {
		self.directoryURL = directoryURL
		kvStore = SQLiteKeyValueStore(with: directoryURL, key: key)
	}

	func inTransaction(completion: (Store) -> Void) {
		queue.sync {
			let store = SecureStore(with: kvStore, at: directoryURL)
			completion(store)
		}
	}

	func flush() {
		queue.sync {
			kvStore.flush()
		}
	}

	func clearAll(key: String?) {
		queue.sync {
			kvStore.clearAll(key: key)
		}
	}

	var testResultReceivedTimeStamp: Int64? {
		get {
			queue.sync {
				kvStore["testResultReceivedTimeStamp"] as Int64?
			}
		}
		set {
			queue.sync {
				kvStore["testResultReceivedTimeStamp"] = newValue
			}
		}
	}

	var lastSuccessfulSubmitDiagnosisKeyTimestamp: Int64? {
		get {
			queue.sync {
				kvStore["lastSuccessfulSubmitDiagnosisKeyTimestamp"] as Int64?
			}
		}
		set {
			queue.sync {
				kvStore["lastSuccessfulSubmitDiagnosisKeyTimestamp"] = newValue
			}
		}
	}

	var numberOfSuccesfulSubmissions: Int64? {
		get {
			queue.sync {
				kvStore["numberOfSuccesfulSubmissions"] as Int64? ?? 0
			}
		}
		set {
			queue.sync {
				kvStore["numberOfSuccesfulSubmissions"] = newValue
			}
		}
	}

	var initialSubmitCompleted: Bool {
		get {
			queue.sync {
				kvStore["initialSubmitCompleted"] as Bool? ?? false
			}
		}
		set {
			queue.sync {
				kvStore["initialSubmitCompleted"] = newValue
			}
		}
	}

	var exposureActivationConsentAcceptTimestamp: Int64? {
		get {
			queue.sync {
				kvStore["exposureActivationConsentAcceptTimestamp"] as Int64? ?? 0
			}
		}

		set {
			queue.sync {
				kvStore["exposureActivationConsentAcceptTimestamp"] = newValue
			}
		}
	}

	var exposureActivationConsentAccept: Bool {
		get {
			queue.sync {
				kvStore["exposureActivationConsentAccept"] as Bool? ?? false
			}
		}
		set {
			queue.sync {
				kvStore["exposureActivationConsentAccept"] = newValue
			}
		}
	}

	var registrationToken: String? {
		get {
			queue.sync {
				kvStore["registrationToken"] as String?
			}
		}
		set {
			queue.sync {
				kvStore["registrationToken"] = newValue
			}
		}
	}

	var teleTan: String? {
		get {
			queue.sync {
				kvStore["teleTan"] as String? ?? ""
			}
		}
		set {
			queue.sync {
				kvStore["teleTan"] = newValue
			}
		}
	}

	var tan: String? {
		get { queue.sync {
			kvStore["tan"] as String? ?? ""
			}
		}
		set {
			queue.sync {
				kvStore["tan"] = newValue
			}
		}
	}

	var testGUID: String? {
		get {
			queue.sync {
				kvStore["testGUID"] as String? ?? ""
			}
		}
		set {
			queue.sync {
				kvStore["testGUID"] = newValue
			}
		}
	}

	var devicePairingConsentAccept: Bool {
		get {
			queue.sync {
				kvStore["devicePairingConsentAccept"] as Bool? ?? false
			}
		}
		set {
			queue.sync {
				kvStore["devicePairingConsentAccept"] = newValue
			}
		}
	}

	var devicePairingConsentAcceptTimestamp: Int64? {
		get {
			queue.sync {
				kvStore["devicePairingConsentAcceptTimestamp"] as Int64? ?? 0
			}
		}
		set { kvStore["devicePairingConsentAcceptTimestamp"] = newValue }
	}

	var devicePairingSuccessfulTimestamp: Int64? {
		get {
			queue.sync {
				kvStore["devicePairingSuccessfulTimestamp"] as Int64? ?? 0
			}
		}
		set {
			queue.sync {
				kvStore["devicePairingSuccessfulTimestamp"] = newValue
			}
		}
	}

	var isAllowedToSubmitDiagnosisKeys: Bool {
		get {
			queue.sync {
				kvStore["isAllowedToSubmitDiagnosisKeys"] as Bool? ?? false
			}
		}
		set {
			queue.sync {
				kvStore["isAllowedToSubmitDiagnosisKeys"] = newValue
			}
		}
	}

	var isOnboarded: Bool {
		get {
			queue.sync {
				kvStore["isOnboarded"] as Bool? ?? false
			}
		}
		set {
			queue.sync {
				kvStore["isOnboarded"] = newValue
			}
		}
	}

	var dateOfAcceptedPrivacyNotice: Date? {
		get {
			queue.sync {
				kvStore["dateOfAcceptedPrivacyNotice"] as Date? ?? nil
			}
		}
		set {
			queue.sync {
				kvStore["dateOfAcceptedPrivacyNotice"] = newValue
			}
		}
	}

	var hasSeenSubmissionExposureTutorial: Bool {
		get {
			queue.sync {
				kvStore["hasSeenSubmissionExposureTutorial"] as Bool? ?? false
			}
		}
		set {
			queue.sync {
				kvStore["hasSeenSubmissionExposureTutorial"] = newValue
			}
		}
	}

	var developerSubmissionBaseURLOverride: String? {
		get {
			queue.sync {
				kvStore["developerSubmissionBaseURLOverride"] as String? ?? nil
			}
		}
		set {
			queue.sync {
				kvStore["developerSubmissionBaseURLOverride"] = newValue
			}
		}
	}

	var developerDistributionBaseURLOverride: String? {
		get { kvStore["developerDistributionBaseURLOverride"] as String? ?? nil }
		set { kvStore["developerDistributionBaseURLOverride"] = newValue }
	}

	var developerVerificationBaseURLOverride: String? {
		get {
			queue.sync {
				kvStore["developerVerificationBaseURLOverride"] as String? ?? nil
			}
		}
		set {
			queue.sync {
				kvStore["developerVerificationBaseURLOverride"] = newValue
			}
		}
	}

	var allowRiskChangesNotification: Bool {
		get {
			queue.sync {
				kvStore["allowRiskChangesNotification"] as Bool? ?? true
			}
		}
		set {
			queue.sync {
				kvStore["allowRiskChangesNotification"] = newValue
			}
		}
	}

	var allowTestsStatusNotification: Bool {
		get {
			queue.sync {
				kvStore["allowTestsStatusNotification"] as Bool? ?? true
			}
		}
		set {
			queue.sync {
				kvStore["allowTestsStatusNotification"] = newValue
			}
		}
	}

	var tracingStatusHistory: TracingStatusHistory {
		get {
			queue.sync {
				guard let historyData = kvStore["tracingStatusHistory"] else {
					return []
				}
				return (try? TracingStatusHistory.from(data: historyData)) ?? []
			}
		}
		set {
			queue.sync {
				kvStore["tracingStatusHistory"] = try? newValue.JSONData()
			}
		}
	}

	var summary: SummaryMetadata? {
		get {
			queue.sync {
				kvStore["previousSummaryMetadata"] as SummaryMetadata? ?? nil
			}
		}
		set {
			queue.sync {
				kvStore["previousSummaryMetadata"] = newValue
			}
		}
	}

	var hourlyFetchingEnabled: Bool {
		get {
			queue.sync {
				kvStore["hourlyFetchingEnabled"] as Bool? ?? false
			}
		}
		set {
			queue.sync {
				kvStore["hourlyFetchingEnabled"] = newValue
			}
		}
	}

	var previousRiskLevel: EitherLowOrIncreasedRiskLevel? {
		get {
			queue.sync {
				guard let value = kvStore["previousRiskLevel"] as Int? else {
					return nil
				}
				return EitherLowOrIncreasedRiskLevel(rawValue: value)
			}
		}
		set {
			queue.sync {
				kvStore["previousRiskLevel"] = newValue?.rawValue
			}
		}
	}
}
