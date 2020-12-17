

import UIKit

class PresenationAnimationController: NSObject {
    
    // MARK: - Properties
    let isPresentation: Bool

    // MARK: - Initializers
    init(isPresentation: Bool) {
      self.isPresentation = isPresentation
      super.init()
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension PresenationAnimationController: UIViewControllerAnimatedTransitioning {
  func transitionDuration(
    using transitionContext: UIViewControllerContextTransitioning?
  ) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let key: UITransitionContextViewControllerKey = isPresentation ? .to : .from
    guard let controller = transitionContext.viewController(forKey: key)
      else { return }
    
    if isPresentation {
      transitionContext.containerView.addSubview(controller.view)
    }
    let presentedFrame = transitionContext.finalFrame(for: controller)
    var dismissedFrame = presentedFrame
    dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
    

    let initialFrame = isPresentation ? dismissedFrame : presentedFrame
    let finalFrame = isPresentation ? presentedFrame : dismissedFrame

    let animationDuration = transitionDuration(using: transitionContext)
    controller.view.frame = initialFrame
    UIView.animate(
      withDuration: animationDuration,
      animations: {
        controller.view.frame = finalFrame
    }, completion: { finished in
      if !self.isPresentation {
        controller.view.removeFromSuperview()
      }
      transitionContext.completeTransition(finished)
    })
  }
}
