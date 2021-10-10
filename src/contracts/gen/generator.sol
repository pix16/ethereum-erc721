// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library Generator{
    bytes constant base64Symbols = bytes("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/");
    bytes constant hexSymbols = bytes("0123456789ABCDEF");

    bytes constant backgroundDesc=bytes("eyJiYWNrZ3JvdW5kX2NvbG9yIjoiMDAwMDAwIiwiZGVzY3JpcHRpb24iOiAi");
    bytes constant imageDataB64=bytes("LCJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQs");
    bytes constant svgHeaderB64=bytes("UEhOMlp5QjJaWEp6YVc5dVBTSXhMakVpSUhacFpYZENiM2c5SWpBZ01DQXlJRElpSUhodGJHNXpQU0pvZEhSd09pOHZkM2QzTG5jekxtOXlaeTh5TURBd0wzTjJaeUkr");
    bytes constant darkColorB64x2=bytes("TURBd01EQXdJ");
    bytes constant lightColorB64x2=bytes("UmtaR1JrWkdJ");
    bytes constant darkColorEndTagPaddedB64x2="SXpBd01EQXdNQ0l2UGlBZ0lDQWdJQ0Fn";
    
    bytes constant defsStart = bytes("UEdSbFpuTStJQ0Fn");
    bytes constant gradientStartNoId = bytes("UEhKaFpHbGhiRWR5WVdScFpXNTBJR1o0UFNJd0xqVXdJaUJtZVQwaU1DNDFNQ0lnWm5JOUlqQXVNREFpSUNCamVEMGlNQzQxTUNJZ1kzazlJakF1TlRBaUlISTlJakF1TlRBaUlDQnBaRDBp");
    bytes constant gradientId = bytes("Y2lJK0lDQWdJQ0Fn");
    bytes constant offsetPercent = bytes("UEhOMGIzQWdJQ0J2Wm1aelpYUWdQU0Fp");
    bytes constant eightyPercent = "T0RB";
    bytes constant offsetColor = bytes("bElpQnpkRzl3TFdOdmJHOXlQU0lq");
    
    bytes constant gradientEnd = bytes("SUR3dmNtRmthV0ZzUjNKaFpHbGxiblEr");
    bytes constant defsEnd = bytes("SUNBOEwyUmxabk0r");
    bytes constant endOfColorB64x2 = bytes("aTgr");
    
    bytes constant circleBegin=bytes("UEdOcGNtTnNaU0JqZUQwaU1TSWdZM2s5SWpFaUlISTlJa");
    bytes constant circleRadiusBig=bytes("ms");
    bytes constant circleRadiusPhi=bytes("kF");
    bytes constant circleEndNoFill=bytes("1TnlJZ1ptbHNiRDBp");
    bytes constant fillGradientB64x2="ZFhKc0tDY2pjaWNw";
        
    bytes constant animateBeginNoSteps = bytes("UEdGdWFXMWhkR1VnWVhSMGNtbGlkWFJsVG1GdFpUMGlabWxzYkMxdmNHRmphWFI1SWlCMllXeDFaWE05");
    bytes constant animateSteps1_03_1 = bytes("SWpFN01DNHpPekVp");
    bytes constant animateSteps08_1_08 = bytes("SWk0NE96RTdMamdp");
    bytes constant animateSteps07_06_07 = bytes("SWpBdU56c3dMalk3TUM0M0lpQWdJQ0Fn");
    bytes constant animateDuration = bytes("SUdSMWNqMGl");
    
    bytes constant animateEnd = bytes("1pSUhKbGNHVmhkRU52ZFc1MFBTSnBibVJsWm1sdWFYUmxJaTgr");
    bytes constant animate7s=bytes("OM0");
    bytes constant animate9s=bytes("PWE");
    bytes constant circleEndTag = bytes("UEM5amFYSmpiR1Ur");
    bytes constant endOfTagPadded = bytes("SWo0Z0lDQWdJQ0Fn");
    bytes constant closeSvgPartial=bytes("aTgrUEM5emRtYysifQ==");
    bytes constant closeSvgJson=bytes("UEM5emRtYysifQ==");

    function getb64FromBytes3(bytes memory inputBytes) public pure returns (bytes memory)
    {
        bytes memory errMessage=bytes("Remove   characters for b64 conversion");
        errMessage[7]=hexSymbols[inputBytes.length%3];
        require(inputBytes.length%3 == 0, string(errMessage));
        bytes memory outputBytesB64 = new bytes(inputBytes.length*4/3);
        for(uint16 p=0; p < outputBytesB64.length/4; p++)
        {
            uint16 sIndex = p*3;
            uint16 bIndex = p*4;
            outputBytesB64[bIndex] = base64Symbols[(uint8(inputBytes[sIndex]) & 0xFC) >> 2];
            outputBytesB64[bIndex+1] = base64Symbols[(uint8(inputBytes[sIndex]) & 0x3) << 4 | (uint8(inputBytes[sIndex+1]) & 0xF0) >> 4];
            outputBytesB64[bIndex+2] = base64Symbols[(uint8(inputBytes[sIndex+1]) & 0xF) << 2 | (uint8(inputBytes[sIndex+2]) & 0xC0) >> 6];
            outputBytesB64[bIndex+3] = base64Symbols[uint8(inputBytes[sIndex+2]) & 0x3F];
        }
        return outputBytesB64;
    }

    function getColorHex(uint colorCode, uint totalColors, uint requiredLevels) public pure returns (bytes memory) {
        uint remainingLevels = totalColors - requiredLevels;
        uint[] memory colorLevel = new uint[](3);
        uint colorOffset = 255 % (totalColors-1);
        uint colorStep = 255 / (totalColors-1);
        if(colorCode < (requiredLevels*remainingLevels*remainingLevels))
        {
            colorLevel[2] = 255;
            colorLevel[0] = (colorCode % remainingLevels)*colorStep+colorOffset;
            colorLevel[1] = (colorCode / remainingLevels)*colorStep+colorOffset;
        }
        else if(colorCode < (requiredLevels*remainingLevels*(remainingLevels+totalColors)))
        {
            colorCode -= requiredLevels*remainingLevels*remainingLevels;
            colorLevel[1] = 255;
            colorLevel[0] = (colorCode % remainingLevels)*colorStep+colorOffset;
            colorLevel[2] = (colorCode / remainingLevels)*colorStep+colorOffset;
        }
        else
        {
            colorCode -= requiredLevels*remainingLevels*(remainingLevels+totalColors);
            colorLevel[0] = 255;
            colorLevel[1] = (colorCode % totalColors)*colorStep+colorOffset;
            colorLevel[2] = (colorCode / totalColors)*colorStep+colorOffset;
        }

        bytes memory colorHex = new bytes(6);
        for(uint8 j=0; j < 3; j++)
        {
            if(colorLevel[j] == colorOffset)
            {
                colorLevel[j] = 0;
            }
            colorHex[2*j] = hexSymbols[colorLevel[j]/16];
            colorHex[2*j+1] = hexSymbols[colorLevel[j]%16];
        }

        return colorHex;
    }

    function fillString(uint value, bytes memory ret, uint lastPosition) public pure returns (bytes memory){
        uint16 h=0;
        while(value != 0)
        {
            ret[lastPosition - h] = hexSymbols[value % 10];
            h++;
            value /= 10;
        }
        return ret;
    }
}
