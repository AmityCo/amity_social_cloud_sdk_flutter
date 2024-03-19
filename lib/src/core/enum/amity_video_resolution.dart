enum AmityVideoResolution { ORIGINAL, RES_1080, RES_720, RES_480, RES_360 }

extension AmityVideoResolutionExtension on AmityVideoResolution {
  String get apiKey {
    switch (this) {
      case AmityVideoResolution.ORIGINAL:
        return 'original';
      case AmityVideoResolution.RES_1080:
        return '1080p';
      case AmityVideoResolution.RES_720:
        return '720p';
      case AmityVideoResolution.RES_480:
        return '480p';
      case AmityVideoResolution.RES_360:
        return '360p';
      default:
        return "original";
    }
  }

  static AmityVideoResolution enumOf(String value) {
    switch (value) {
      case "original":
        return AmityVideoResolution.ORIGINAL;
      case "1080p":
        return AmityVideoResolution.RES_1080;
      case "720p":
        return AmityVideoResolution.RES_720;
      case "480p":
        return AmityVideoResolution.RES_480;
      case "360p":
        return AmityVideoResolution.RES_360;
      default: 
      return AmityVideoResolution.ORIGINAL;
    }
  }
}
