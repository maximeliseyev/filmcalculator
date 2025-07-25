//
//  JournalView.swift
//  Film claculator
//
//  Created by Maxim Eliseyev on 11.07.2025.
//

import SwiftUI

struct JournalView: View {
    let records: [CalculationRecord]
    let onLoadRecord: (CalculationRecord) -> Void
    let onDeleteRecord: (CalculationRecord) -> Void
    let onClose: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                if records.isEmpty {
                    VStack(spacing: 20) {
                        Text(LocalizedStringKey("journalEmpty"))
                            .font(.title3)
                            .foregroundColor(.gray)
                        
                        Text(LocalizedStringKey("journalEmptyDescription"))
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach(records, id: \.objectID) { record in
                            RecordRowView(
                                record: record,
                                onTap: { onLoadRecord(record) }
                            )
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                onDeleteRecord(records[index])
                            }
                        }
                    }
                }
            }
            .navigationTitle(LocalizedStringKey("journal"))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(LocalizedStringKey("done")) {
                        onClose()
                    }
                }
            }
        }
    }
}
