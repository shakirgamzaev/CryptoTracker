//
//  PricesChartView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 25/11/24.
//

import SwiftUI
import Charts

struct PricesChartView: View {
    let prices: [Double]
    @State private var pricesVM: PriceChartVM
    init(prices: [Double]) {
        self.prices = prices
        self._pricesVM = State(initialValue: PriceChartVM(prices: prices))
    }
    
    var body: some View {
        VStack {
            if !pricesVM.prices.isEmpty {
                Chart(pricesVM.prices) { priceModel in
                    LineMark(
                        x: .value("date", priceModel.date, unit: .hour),
                        y: .value("price", priceModel.price)
                    )
                    .foregroundStyle(pricesVM.lineColor)
                    .shadow(color: pricesVM.lineColor.opacity(0.7), radius: 10, y: 10)
                    .shadow(color: pricesVM.lineColor.opacity(0.3), radius: 10, y: 20)
                }
                .chartYScale(domain: (pricesVM.minPrice - pricesVM.minPrice * 0.01)...pricesVM.maxPrice)
                
                .chartXAxisLabel(position: .automatic, content: {
                    Text("Day")
                        .font(.headline)
                })
                .chartYAxisLabel(position: .top, content: {
                    Text("Price $")
                        .font(.headline)
                })
                .chartXAxis {
                    AxisMarks(
                        preset: .aligned,
                        values: .stride(by: .day, count: 1)
                    ) { value in
                        if value.index == 0 {
                            AxisValueLabel(
                                centered: true,
                                collisionResolution: .disabled,
                                verticalSpacing: 20
                            ) {
                                Text(value.as(Date.self)!.formatted(date: .numeric, time: .omitted))
                                    .foregroundStyle(Color(.accent))
                                    .bold()
                                    .font(.system(size: 13))
                            }
                        }
                        else if value.index == value.count - 1 {
                            AxisValueLabel(
                                centered: false,
                                anchor: .center,
                                collisionResolution: .disabled,
                                verticalSpacing: 20
                            ) {
                                Text(value.as(Date.self)!.formatted(date: .numeric, time: .omitted))
                                    .foregroundStyle(Color(.accent))
                                    .bold()
                                    .font(.system(size: 13))
                            }
                        }
                        AxisGridLine()
                        
                    }
                }
                .chartYAxis {
                    AxisMarks(
                        values: .automatic(minimumStride: 0, desiredCount: 4)
                    ) { value in
                        if value.index == 0  {
                            AxisValueLabel(format: Decimal.FormatStyle(locale: .init(identifier: "en-US")).precision(.fractionLength(2)))
                        }
                            AxisTick()
                            AxisGridLine()
                        AxisValueLabel(format: Decimal.FormatStyle(locale: .init(identifier: "en-US")).precision(.fractionLength(2)))
                    }
                }
            }
            else {
                Text("No Price Data")
                    .font(.title2)
                    .bold()
            }
        }
    }
}

#Preview {
    PricesChartView(prices: PriceModel.samplePrices)
        .padding(.horizontal, 25)
        .frame(height: 400)
}
