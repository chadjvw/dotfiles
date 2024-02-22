const MAX_WIDTH = 2999;

function layout() {
  return {
    name: "Centered",
    extends: "tall",
    getFrameAssignments: (windows, screenFrame, state, extendedFrames) => {
      const hasOneWindow = windows.length === 1 && screenFrame.width > MAX_WIDTH;
      const oneWindowXOffset = Math.round((screenFrame.width - MAX_WIDTH) / 2);

      return extendedFrames.reduce((frames, extendedFrame) => {
        const frame = {
          x: hasOneWindow ? oneWindowXOffset : extendedFrame.frame.x,
          y: extendedFrame.frame.y,
          width: hasOneWindow ? MAX_WIDTH : extendedFrame.frame.width,
          height: extendedFrame.frame.height,
        };
        
        return { ...frames, [extendedFrame.id]: frame };
      }, {});
    },
  };
}

