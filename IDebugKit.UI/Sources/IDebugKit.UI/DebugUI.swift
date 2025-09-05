// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import SUtilKit_SwiftUI

// 1. 首先定义一个环境值来存储调试边框的显示状态
private struct DebugBorderEnabledKey: EnvironmentKey {
    static let defaultValue: Bool = true // 默认在DEBUG模式下显示
}

// 1. 首先定义一个环境值来存储调试边框的显示状态
private struct DebugBackgroundEnabledKey: EnvironmentKey {
    static let defaultValue: Bool = true // 默认在DEBUG模式下显示
}

extension EnvironmentValues {
    var debugBorderEnabled: Bool {
        get { self[DebugBorderEnabledKey.self] }
        set { self[DebugBorderEnabledKey.self] = newValue }
    }
    
    
    var debugBackgroundEnabled: Bool {
        get { self[DebugBackgroundEnabledKey.self] }
        set { self[DebugBackgroundEnabledKey.self] = newValue }
    }
}

// 2. 定义一个 View Modifier 来设置调试边框的启用状态
public extension View {
    /// 控制调试边框的全局显示状态
    func debugBorderEnabled(_ enabled: Bool) -> some View {
        environment(\.debugBorderEnabled, enabled)
    }
    
    func debugBackgroundEnabled(_ enabled: Bool) -> some View {
        environment(\.debugBackgroundEnabled, enabled)
    }
    
    /// 添加调试边框，受全局 debugBorderEnabled 环境值控制
    func debugBorder() -> some View {
        DebugUI.debugBorder(view: self)
    }
    
    func debugBackground()->some View{
        DebugUI.debugBackground(view: self)
    }
}

public final class DebugUI {
    // 3. 修改原有的 debugBorder 方法
    public static func debugBorder<V: View>(view: V) -> some View {
#if DEBUG
        return view
            .modifier(DebugBorderModifier())
#else
        return view
#endif
    }
    
    public static func debugBackground<V:View>(view: V) -> some View  {
#if DEBUG
        //        return view.background(UtilKColor.get_random())
        return view
            .modifier(DebugBorderModifier())
#else
        return view
#endif
    }
}


private struct DebugBorderModifier: ViewModifier {
    @Environment(\.debugBorderEnabled) private var isEnabled
    
    func body(content: Content) -> some View {
        if isEnabled {
            content
                .border(UtilKColor.get_random(), width: 1)
        } else {
            content
        }
    }
}

private struct DebugBackgroundModifier: ViewModifier {
    @Environment(\.debugBorderEnabled) private var isEnabled
    
    func body(content: Content) -> some View {
        if isEnabled {
            content
                .background(UtilKColor.get_random())
        } else {
            content
        }
    }
}

/**
 // 5. 使用示例
 struct ContentView: View {
 var body: some View {
 VStack {
 Text("Hello World")
 .debugBorder() // 这会受到全局设置的影响
 
 Button("Click me") {
 // 一些操作
 }
 .debugBorder()
 }
 .debugBorderEnabled(false) // 在根视图禁用所有调试边框
 // 或者 .debugBorderEnabled(true) 来启用
 }
 }
 */
