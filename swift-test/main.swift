//
//  main.swift
//  swift-test
//
//  Created by jingwei on 2024/3/14.
//
/*
 iOS开发内卷面试题 https://blog.csdn.net/Jul7day/article/details/121928946
 2022年iOS最新面试（底层基础）问题答案 https://blog.csdn.net/jianrenbubai/article/details/123467495
 https://www.w3xue.com/exp/article/202112/76886.html
 
 最新iOS面试题总结：https://github.com/LGBamboo/iOS-article.01
 最新iOS面试题总结：https://github.com/LGBamboo/iOS-article.02
 最新iOS面试题总结：https://github.com/LGBamboo/iOS-article.03
 
 https://pgzxc.github.io/navs/interview/ios.html
 
 技术总结：https://roadmap.isylar.com/iOS/UIKit/UIViewRenderProcess.html
 技术总结：https://alexcode2.gitbook.io/ios-development-guidelines/ios-za-tan/lin-jin-oom-ru-he-huo-qu-xiang-xi-nei-cun-fen-pei-xin-xi-fen-xi-nei-cun-wen-ti
 iOS开发高手客：https://time.geekbang.org/column/article/85332
 */
import Foundation


func swap<T>(a: T, b : T)  {
    
}





// swift 遍历是使用迭代器 然后获取迭代器里面的 next
// oc for 循环

//var numbers: Array = [8,7,6,5,4,3,2,1]
    
//for i in numbers {
//    if i == 1 {
//        numbers.remove(at: 0)
//    }
//}

//quickSort(&numbers, left: 0, right: numbers.count - 1)
//
//print(numbers)
//
//print(getZhong(&numbers, left: 0, right: numbers.count - 1))
//
//print(mergeSortArr(a: [1,3,5,7,9,11,22,33,44], b: [2,4,6,8,66,77,88,99]))
//
//print(binarySearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 66, 77, 88, 99], 99))


//let head = ListNode();
//let a1 = ListNode(); a1.val = 1
//let a2 = ListNode(); a2.val = 2
//let a3 = ListNode(); a3.val = 3
//let a4 = ListNode(); a4.val = 4
//head.next = a1;
//a1.next = a2;
//a2.next = a3;
//a3.next = a4

//reverse(head)
//printListNode(head)

//let result = reverseList(a1)
//printListNode(result)


//print(isPalindromicLink(node: a1))










//import AVFoundation
//
//// 视频文件 URL
//let videoURL = URL(string: "https://example.com/video.mp4")!
//
//// 创建 AVPlayerItem
//let asset = AVURLAsset(url: videoURL)
//let playerItem = AVPlayerItem(asset: asset)
//
//// 准备播放器进行预加载
//playerItem.preferredForwardBufferDuration = TimeInterval(10.0) // 设置预加载时间
//let player = AVPlayer(playerItem: playerItem)
//
//// 手动触发预加载
//playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = true
//playerItem.asset.loadValuesAsynchronously(forKeys: ["tracks"], completionHandler: {
//    // Completion handler code here
//})
//
//// 播放视频
//let playerLayer = AVPlayerLayer(player: player)
//player.play()
