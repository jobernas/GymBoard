//
//  DetailsViewController.swift
//  GymBoard
//
//  Created by João Luís on 19/05/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import UIKit
import Charts

class DetailsViewController: SuperViewController {

    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var txtMinVal: UILabel!
    @IBOutlet weak var txtMedVal: UILabel!
    @IBOutlet weak var txtAveVal: UILabel!
    @IBOutlet weak var txtMaxVal: UILabel!
    
    var labels: Array<String> = []
    var values: Array<Double> = []
    var selectedEntry : Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let entry = self.selectedEntry {
            let title = self.getTitle(entry.getLabel())
            self.title = title
            self.chart.chartDescription?.text = title
            let allEntries = EntryCRUD.getEntriesForType(entry.type)
            
            let strDateFormat = "YYYY-MM-DD"
            let start = strDateFormat.index(strDateFormat.startIndex, offsetBy: 5)
            let end = strDateFormat.endIndex
            for item in allEntries {
                self.labels.append(item.date.substring(with: start..<end))
                self.values.append(item.value)
            }
            
            //
            self.txtMinVal.text = "\(self.calcMin()) \(entry.unit)"
            self.txtMaxVal.text = "\(self.calcMax()) \(entry.unit)"
            self.txtAveVal.text = "\(self.calcAverage()) \(entry.unit)"
            self.txtMedVal.text = "\(self.calcMedium()) \(entry.unit)"

            var dataEntries: Array<ChartDataEntry> = []
            for (index, val) in self.values.enumerated() {
                let dataEntry = ChartDataEntry(x: Double(index), y: val)
                dataEntries.append(dataEntry)
            }
            
            let data = LineChartData()
            let pesoChart = LineChartDataSet(values: dataEntries, label: title)
            pesoChart.colors = [UIColor.red]
            pesoChart.circleColors = [UIColor.red]
            //        pesoChart.circleRadius = 1.0
            pesoChart.circleHoleColor = UIColor.white
            data.addDataSet(pesoChart)
            
            self.chart.noDataText = "No Data Available"
            self.chart.xAxis.labelPosition = .bottom
            self.chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.labels)
            //Also, you probably want to add:
            self.chart.xAxis.granularity = 1
            self.chart.gridBackgroundColor = UIColor.white
            self.chart.data = data
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.chart.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    func setData(_ entry:Entry) {
        self.selectedEntry = entry
    }
    
    private func getTitle(_ label:String) -> String {
        var tmp = label.characters
        _ = tmp.popLast()
        return String(tmp)
    }
    
    /// Calc of Max (Maximum)
    ///
    /// - Returns: Double
    private func calcMax() -> Double {
        var max : Double?
        for val in self.values {
            if max == nil || val > max! {
                max = val
            }
        }
        return max ?? 0
    }
    
    
    /// Calc of Medium (Mediana)
    ///
    /// - Returns: Double
    private func calcMedium() -> Double {
        var result = 0.0
        let orderedVals = self.values.sorted()
        let index: Int = Int(ceil(Double(orderedVals.count / 2)))
        print(orderedVals)
        print(index)
        if(orderedVals.count % 2 == 0){
            result = (orderedVals[index - 1] + orderedVals[index]) / 2
        }else{
            result = orderedVals[index]
        }
        
        return result
    }
    
    /// Calc of Average (Media)
    ///
    /// - Returns: Double
    private func calcAverage() -> Double {
        var result = 0.0
        for val in self.values {
            result += val
        }
        return ceil(result / (self.values.count > 0 ? Double(self.values.count) : 1.0)*100)/100 
    }
    
    
    /// Calc of Min (Minimo)
    ///
    /// - Returns: Double
    private func calcMin() -> Double {
        var min : Double?
        for val in self.values {
            if min == nil || val < min! {
                min = val
            }
        }
        return min ?? 0
    }

}
