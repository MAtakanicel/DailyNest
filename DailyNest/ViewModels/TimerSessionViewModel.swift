//
//  TimerSessionViewModel.swift
//  DailyNest
//
//  Created by Atakan on 15.03.2026.
//

import Foundation
import Combine

final class TimerSessionViewModel : ObservableObject{
    private var activeSession : TimerSession?
    
    @Published var elapsedSeconds: Int = 0
}
