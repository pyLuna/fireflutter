typedef AreaCode = ({String code, String name});

Map<String, List<AreaCode>> siDoCodes = {
  'ko': [
    (code: "1", name: "서울"),
    (code: "2", name: "인천"),
    (code: "3", name: "대전"),
    (code: "4", name: "대구"),
    (code: "5", name: "광주"),
    (code: "6", name: "부산"),
    (code: "7", name: "울산"),
    (code: "8", name: "세종특별자치시"),
    (code: "31", name: "경기도"),
    (code: "32", name: "강원특별자치도"),
    (code: "33", name: "충청북도"),
    (code: "34", name: "충청남도"),
    (code: "35", name: "경상북도"),
    (code: "36", name: "경상남도"),
    (code: "37", name: "전북특별자치도"),
    (code: "38", name: "전라남도"),
    (code: "39", name: "제주도"),
  ],
  'en': [
    (code: "1", name: "Seoul"),
    (code: "2", name: "Incheon"),
    (code: "3", name: "Daejeon"),
    (code: "4", name: "Daegu"),
    (code: "5", name: "Gwangju"),
    (code: "6", name: "Busan"),
    (code: "7", name: "Ulsan"),
    (code: "8", name: "Sejong"),
    (code: "31", name: "Gyeonggi-do"),
    (code: "32", name: "Gangwon-do"),
    (code: "33", name: "Chungcheongbuk-do"),
    (code: "34", name: "Chungcheongnam-do"),
    (code: "35", name: "Gyeongsangbuk-do"),
    (code: "36", name: "Gyeongsangnam-do"),
    (code: "37", name: "Jeollabuk-do"),
    (code: "38", name: "Jeollanam-do"),
    (code: "39", name: "Jeju-do"),
  ]
};

Map<String, Map<String, List<AreaCode>>> siGunGuCodes = {
  'ko': {
    '1': [
      (code: '1', name: '강남구'),
      (code: '2', name: '강동구'),
      (code: '3', name: '강북구'),
      (code: '4', name: '강서구'),
      (code: '5', name: '관악구'),
      (code: '6', name: '광진구'),
      (code: '7', name: '구로구'),
      (code: '8', name: '금천구'),
      (code: '9', name: '노원구'),
      (code: '10', name: '도봉구'),
      (code: '11', name: '동대문구'),
      (code: '12', name: '동작구'),
      (code: '13', name: '마포구'),
      (code: '14', name: '서대문구'),
      (code: '15', name: '서초구'),
      (code: '16', name: '성동구'),
      (code: '17', name: '성북구'),
      (code: '18', name: '송파구'),
      (code: '19', name: '양천구'),
      (code: '20', name: '영등포구'),
      (code: '21', name: '용산구'),
      (code: '22', name: '은평구'),
      (code: '23', name: '종로구'),
      (code: '24', name: '중구'),
      (code: '25', name: '중랑구'),
    ],
    '2': [
      (code: '1', name: '강화군'),
      (code: '2', name: '계양구'),
      (code: '3', name: '미추홀구'),
      (code: '4', name: '남동구'),
      (code: '5', name: '동구'),
      (code: '6', name: '부평구'),
      (code: '7', name: '서구'),
      (code: '8', name: '연수구'),
      (code: '9', name: '옹진군'),
      (code: '10', name: '중구'),
    ],
    '3': [
      (code: '1', name: '대덕구'),
      (code: '2', name: '동구'),
      (code: '3', name: '서구'),
      (code: '4', name: '유성구'),
      (code: '5', name: '중구'),
    ],
    '4': [
      (code: '1', name: '남구'),
      (code: '2', name: '달서구'),
      (code: '3', name: '달성군'),
      (code: '4', name: '동구'),
      (code: '5', name: '북구'),
      (code: '6', name: '서구'),
      (code: '7', name: '수성구'),
      (code: '8', name: '중구'),
      (code: '9', name: '군위군'),
    ],
    '5': [
      (code: '1', name: '광산구'),
      (code: '2', name: '남구'),
      (code: '3', name: '동구'),
      (code: '4', name: '북구'),
      (code: '5', name: '서구'),
    ],
    '6': [
      (code: '1', name: '강서구'),
      (code: '2', name: '금정구'),
      (code: '3', name: '기장군'),
      (code: '4', name: '남구'),
      (code: '5', name: '동구'),
      (code: '6', name: '동래구'),
      (code: '7', name: '부산진구'),
      (code: '8', name: '북구'),
      (code: '9', name: '사상구'),
      (code: '10', name: '사하구'),
      (code: '11', name: '서구'),
      (code: '12', name: '수영구'),
      (code: '13', name: '연제구'),
      (code: '14', name: '영도구'),
      (code: '15', name: '중구'),
      (code: '16', name: '해운대구'),
    ],
    '7': [
      (code: '1', name: '중구'),
      (code: '2', name: '남구'),
      (code: '3', name: '동구'),
      (code: '4', name: '북구'),
      (code: '5', name: '울주군'),
    ],
    '8': [
      (code: '1', name: '세종특별자치시'),
    ],
    '31': [
      (code: '1', name: '가평군'),
      (code: '2', name: '고양시'),
      (code: '3', name: '과천시'),
      (code: '4', name: '광명시'),
      (code: '5', name: '광주시'),
      (code: '6', name: '구리시'),
      (code: '7', name: '군포시'),
      (code: '8', name: '김포시'),
      (code: '9', name: '남양주시'),
      (code: '10', name: '동두천시'),
      (code: '11', name: '부천시'),
      (code: '12', name: '성남시'),
      (code: '13', name: '수원시'),
      (code: '14', name: '시흥시'),
      (code: '15', name: '안산시'),
      (code: '16', name: '안성시'),
      (code: '17', name: '안양시'),
      (code: '18', name: '양주시'),
      (code: '19', name: '양평군'),
      (code: '20', name: '여주시'),
      (code: '21', name: '연천군'),
      (code: '22', name: '오산시'),
      (code: '23', name: '용인시'),
      (code: '24', name: '의왕시'),
      (code: '25', name: '의정부시'),
      (code: '26', name: '이천시'),
      (code: '27', name: '파주시'),
      (code: '28', name: '평택시'),
      (code: '29', name: '포천시'),
      (code: '30', name: '하남시'),
      (code: '31', name: '화성시'),
    ],
    '32': [
      (code: '1', name: '강릉시'),
      (code: '2', name: '고성군'),
      (code: '3', name: '동해시'),
      (code: '4', name: '삼척시'),
      (code: '5', name: '속초시'),
      (code: '6', name: '양구군'),
      (code: '7', name: '양양군'),
      (code: '8', name: '영월군'),
      (code: '9', name: '원주시'),
      (code: '10', name: '인제군'),
      (code: '11', name: '정선군'),
      (code: '12', name: '철원군'),
      (code: '13', name: '춘천시'),
      (code: '14', name: '태백시'),
      (code: '15', name: '평창군'),
      (code: '16', name: '홍천군'),
      (code: '17', name: '화천군'),
      (code: '18', name: '횡성군'),
    ],
    '33': [
      (code: '1', name: '괴산군'),
      (code: '2', name: '단양군'),
      (code: '3', name: '보은군'),
      (code: '4', name: '영동군'),
      (code: '5', name: '옥천군'),
      (code: '6', name: '음성군'),
      (code: '7', name: '제천시'),
      (code: '8', name: '진천군'),
      (code: '10', name: '청주시'),
      (code: '11', name: '충주시'),
      (code: '12', name: '증평군'),
    ],
    '34': [
      (code: '1', name: '공주시'),
      (code: '2', name: '금산군'),
      (code: '3', name: '논산시'),
      (code: '4', name: '당진시'),
      (code: '5', name: '보령시'),
      (code: '6', name: '부여군'),
      (code: '7', name: '서산시'),
      (code: '8', name: '서천군'),
      (code: '9', name: '아산시'),
      (code: '11', name: '예산군'),
      (code: '12', name: '천안시'),
      (code: '13', name: '청양군'),
      (code: '14', name: '태안군'),
      (code: '15', name: '홍성군'),
      (code: '16', name: '계룡시'),
    ],
    '35': [
      (code: '1', name: '경산시'),
      (code: '2', name: '경주시'),
      (code: '3', name: '고령군'),
      (code: '4', name: '구미시'),
      (code: '6', name: '김천시'),
      (code: '7', name: '문경시'),
      (code: '8', name: '봉화군'),
      (code: '9', name: '상주시'),
      (code: '10', name: '성주군'),
      (code: '11', name: '안동시'),
      (code: '12', name: '영덕군'),
      (code: '13', name: '영양군'),
      (code: '14', name: '영주시'),
      (code: '15', name: '영천시'),
      (code: '16', name: '예천군'),
      (code: '17', name: '울릉군'),
      (code: '18', name: '울진군'),
      (code: '19', name: '의성군'),
      (code: '20', name: '청도군'),
      (code: '21', name: '청송군'),
      (code: '22', name: '칠곡군'),
      (code: '23', name: '포항시'),
    ],
    '36': [
      (code: '1', name: '거제시'),
      (code: '2', name: '거창군'),
      (code: '3', name: '고성군'),
      (code: '4', name: '김해시'),
      (code: '5', name: '남해군'),
      (code: '7', name: '밀양시'),
      (code: '8', name: '사천시'),
      (code: '9', name: '산청군'),
      (code: '10', name: '양산시'),
      (code: '12', name: '의령군'),
      (code: '13', name: '진주시'),
      (code: '15', name: '창녕군'),
      (code: '16', name: '창원시'),
      (code: '17', name: '통영시'),
      (code: '18', name: '하동군'),
      (code: '19', name: '함안군'),
      (code: '20', name: '함양군'),
      (code: '21', name: '합천군'),
    ],
    '37': [
      (code: '1', name: '고창군'),
      (code: '2', name: '군산시'),
      (code: '3', name: '김제시'),
      (code: '4', name: '남원시'),
      (code: '5', name: '무주군'),
      (code: '6', name: '부안군'),
      (code: '7', name: '순창군'),
      (code: '8', name: '완주군'),
      (code: '9', name: '익산시'),
      (code: '10', name: '임실군'),
      (code: '11', name: '장수군'),
      (code: '12', name: '전주시'),
      (code: '13', name: '정읍시'),
      (code: '14', name: '진안군'),
    ],
    '38': [
      (code: '1', name: '강진군'),
      (code: '2', name: '고흥군'),
      (code: '3', name: '곡성군'),
      (code: '4', name: '광양시'),
      (code: '5', name: '구례군'),
      (code: '6', name: '나주시'),
      (code: '7', name: '담양군'),
      (code: '8', name: '목포시'),
      (code: '9', name: '무안군'),
      (code: '10', name: '보성군'),
      (code: '11', name: '순천시'),
      (code: '12', name: '신안군'),
      (code: '13', name: '여수시'),
      (code: '16', name: '영광군'),
      (code: '17', name: '영암군'),
      (code: '18', name: '완도군'),
      (code: '19', name: '장성군'),
      (code: '20', name: '장흥군'),
      (code: '21', name: '진도군'),
      (code: '22', name: '함평군'),
      (code: '23', name: '해남군'),
      (code: '24', name: '화순군'),
    ],
    '39': [
      (code: '3', name: '서귀포시'),
      (code: '4', name: '제주시'),
    ],
  },
  'en': {
    '1': [
      (code: '1', name: 'Gangnam-gu'),
      (code: '2', name: 'Gangdong-gu'),
      (code: '3', name: 'Gangbuk-gu'),
      (code: '4', name: 'Gangseo-gu'),
      (code: '5', name: 'Gwanak-gu'),
      (code: '6', name: 'Gwangjin-gu'),
      (code: '7', name: 'Guro-gu'),
      (code: '8', name: 'Geumcheon-gu'),
      (code: '9', name: 'Nowon-gu'),
      (code: '10', name: 'Dobong-gu'),
      (code: '11', name: 'Dongdaemun-gu'),
      (code: '12', name: 'Dongjak-gu'),
      (code: '13', name: 'Mapo-gu'),
      (code: '14', name: 'Seodaemun-gu'),
      (code: '15', name: 'Seocho-gu'),
      (code: '16', name: 'Seongdong-gu'),
      (code: '17', name: 'Seongbuk-gu'),
      (code: '18', name: 'Songpa-gu'),
      (code: '19', name: 'Yangcheon-gu'),
      (code: '20', name: 'Yeongdeungpo-gu'),
      (code: '21', name: 'Yongsan-gu'),
      (code: '22', name: 'Eunpyeong-gu'),
      (code: '23', name: 'Jongno-gu'),
      (code: '24', name: 'Jung-gu'),
      (code: '25', name: 'Jungnang-gu'),
    ],
    '2': [
      (code: '1', name: 'Ganghwa-gun'),
      (code: '2', name: 'Gyeyang-gu'),
      (code: '3', name: 'Michuhol-gu'),
      (code: '4', name: 'Namdong-gu'),
      (code: '5', name: 'Dong-gu'),
      (code: '6', name: 'Bupyeong-gu'),
      (code: '7', name: 'Seo-gu'),
      (code: '8', name: 'Yeonsu-gu'),
      (code: '9', name: 'Ongjin-gun'),
      (code: '10', name: 'Jung-gu'),
    ],
    '3': [
      (code: '1', name: 'Daedeok-gu'),
      (code: '2', name: 'Dong-gu'),
      (code: '3', name: 'Seo-gu'),
      (code: '4', name: 'Yuseong-gu'),
      (code: '5', name: 'Jung-gu'),
    ],
    '4': [
      (code: '1', name: 'Nam-gu'),
      (code: '2', name: 'Dalseo-gu'),
      (code: '3', name: 'Dalseong-gun'),
      (code: '4', name: 'Dong-gu'),
      (code: '5', name: 'Buk-gu'),
      (code: '6', name: 'Seo-gu'),
      (code: '7', name: 'Suseong-gu'),
      (code: '8', name: 'Jung-gu'),
      (code: '9', name: 'Gunwi-gun'),
    ],
    '5': [
      (code: '1', name: 'Gwangsan-gu'),
      (code: '2', name: 'Nam-gu'),
      (code: '3', name: 'Dong-gu'),
      (code: '4', name: 'Buk-gu'),
      (code: '5', name: 'Seo-gu'),
    ],
    '6': [
      (code: '1', name: 'Gangseo-gu'),
      (code: '2', name: 'Geumjeong-gu'),
      (code: '3', name: 'Gijang-gun'),
      (code: '4', name: 'Nam-gu'),
      (code: '5', name: 'Dong-gu'),
      (code: '6', name: 'Dongnae-gu'),
      (code: '7', name: 'Busanjin-gu'),
      (code: '8', name: 'Buk-gu'),
      (code: '9', name: 'Sasang-gu'),
      (code: '10', name: 'Saha-gu'),
      (code: '11', name: 'Seo-gu'),
      (code: '12', name: 'Suyeong-gu'),
      (code: '13', name: 'Yeonje-gu'),
      (code: '14', name: 'Yeongdo-gu'),
      (code: '15', name: 'Jung-gu'),
      (code: '16', name: 'Haeundae-gu'),
    ],
    '7': [
      (code: '1', name: 'Jung-gu'),
      (code: '2', name: 'Nam-gu'),
      (code: '3', name: 'Dong-gu'),
      (code: '4', name: 'Buk-gu'),
      (code: '5', name: 'Ulju-gun'),
    ],
    '8': [
      (code: '1', name: 'Sejong'),
    ],
    '31': [
      (code: '1', name: 'Gapyeong-gun'),
      (code: '2', name: 'Goyang-si'),
      (code: '3', name: 'Gwacheon-si'),
      (code: '4', name: 'Gwangmyeong-si'),
      (code: '5', name: 'Gwangju-si'),
      (code: '6', name: 'Guri-si'),
      (code: '7', name: 'Gunpo-si'),
      (code: '8', name: 'Gimpo-si'),
      (code: '9', name: 'Namyangju-si'),
      (code: '10', name: 'Dongducheon-si'),
      (code: '11', name: 'Bucheon-si'),
      (code: '12', name: 'Seongnam-si'),
      (code: '13', name: 'Suwon-si'),
      (code: '14', name: 'Siheung-si'),
      (code: '15', name: 'Ansan-si'),
      (code: '16', name: 'Anseong-si'),
      (code: '17', name: 'Anyang-si'),
      (code: '18', name: 'Yangju-si'),
      (code: '19', name: 'Yangpyeong-gun'),
      (code: '20', name: 'Yeoju-si'),
      (code: '21', name: 'Yeoncheon-gun'),
      (code: '22', name: 'Osan-si'),
      (code: '23', name: 'Yongin-si'),
      (code: '24', name: 'Uiwang-si'),
      (code: '25', name: 'Uijeongbu-si'),
      (code: '26', name: 'Icheon-si'),
      (code: '27', name: 'Paju-si'),
      (code: '28', name: 'Pyeongtaek-si'),
      (code: '29', name: 'Pocheon-si'),
      (code: '30', name: 'Hanam-si'),
      (code: '31', name: 'Hwaseong-si'),
    ],
    '32': [
      (code: '1', name: 'Gangneung-si'),
      (code: '2', name: 'Goseong-gun'),
      (code: '3', name: 'Donghae-si'),
      (code: '4', name: 'Samcheok-si'),
      (code: '5', name: 'Sokcho-si'),
      (code: '6', name: 'Yanggu-gun'),
      (code: '7', name: 'Yangyang-gun'),
      (code: '8', name: 'Yeongwol-gun'),
      (code: '9', name: 'Wonju-si'),
      (code: '10', name: 'Inje-gun'),
      (code: '11', name: 'Jeongseon-gun'),
      (code: '12', name: 'Cheorwon-gun'),
      (code: '13', name: 'Chuncheon-si'),
      (code: '14', name: 'Taebaek-si'),
      (code: '15', name: 'Pyeongchang-gun'),
      (code: '16', name: 'Hongcheon-gun'),
      (code: '17', name: 'Hwacheon-gun'),
      (code: '18', name: 'Hoengseong-gun'),
    ],
    '33': [
      (code: '1', name: 'Goesan-gun'),
      (code: '2', name: 'Danyang-gun'),
      (code: '3', name: 'Boeun-gun'),
      (code: '4', name: 'Yeongdong-gun'),
      (code: '5', name: 'Okcheon-gun'),
      (code: '6', name: 'Eumseong-gun'),
      (code: '7', name: 'Jecheon-si'),
      (code: '8', name: 'Jincheon-gun'),
      (code: '10', name: 'Cheongju-si'),
      (code: '11', name: 'Chungju-si'),
      (code: '12', name: 'Jeungpyeong-gun'),
    ],
    '34': [
      (code: '1', name: 'Gongju-si'),
      (code: '2', name: 'Geumsan-gun'),
      (code: '3', name: 'Nonsan-si'),
      (code: '4', name: 'Dangjin-si'),
      (code: '5', name: 'Boryeong-si'),
      (code: '6', name: 'Buyeo-gun'),
      (code: '7', name: 'Seosan-si'),
      (code: '8', name: 'Seocheon-gun'),
      (code: '9', name: 'Asan-si'),
      (code: '11', name: 'Yesan-gun'),
      (code: '12', name: 'Cheonan-si'),
      (code: '13', name: 'Cheongyang-gun'),
      (code: '14', name: 'Taean-gun'),
      (code: '15', name: 'Hongseong-gun'),
    ],
    '35': [
      (code: '1', name: 'Gyeongsan-si'),
      (code: '2', name: 'Gyeongju-si'),
      (code: '3', name: 'Goryeong-gun'),
      (code: '4', name: 'Gumi-si'),
      (code: '6', name: 'Gimcheon-si'),
      (code: '7', name: 'Mungyeong-si'),
      (code: '8', name: 'Bonghwa-gun'),
      (code: '9', name: 'Sangju-si'),
      (code: '10', name: 'Seongju-gun'),
      (code: '11', name: 'Andong-si'),
      (code: '12', name: 'Yeongdeok-gun'),
      (code: '13', name: 'Yeongyang-gun'),
      (code: '14', name: 'Yeongju-si'),
      (code: '15', name: 'Yeongcheon-si'),
      (code: '16', name: 'Yecheon-gun'),
      (code: '17', name: 'Ulleung-gun'),
      (code: '18', name: 'Uljin-gun'),
      (code: '19', name: 'Uiseong-gun'),
      (code: '20', name: 'Cheongdo-gun'),
      (code: '21', name: 'Cheongsong-gun'),
      (code: '22', name: 'Chilgok-gun'),
      (code: '23', name: 'Pohang-si'),
    ],
    '36': [
      (code: '1', name: 'Geoje-si'),
      (code: '2', name: 'Geochang-gun'),
      (code: '3', name: 'Goseong-gun'),
      (code: '4', name: 'Gimhae-si'),
      (code: '5', name: 'Namhae-gun'),
      (code: '7', name: 'Miryang-si'),
      (code: '8', name: 'Sacheon-si'),
      (code: '9', name: 'Sancheong-gun'),
      (code: '10', name: 'Yangsan-si'),
      (code: '12', name: 'Uiryeong-gun'),
      (code: '13', name: 'Jinju-si'),
      (code: '15', name: 'Changnyeong-gun'),
      (code: '16', name: 'Changwon-si'),
      (code: '17', name: 'Tongyeong-si'),
      (code: '18', name: 'Hadong-gun'),
      (code: '19', name: 'Haman-gun'),
      (code: '20', name: 'Hamyang-gun'),
      (code: '21', name: 'Hapcheon-gun'),
    ],
    '37': [
      (code: '1', name: 'Gochang-gun'),
      (code: '2', name: 'Gunsan-si'),
      (code: '3', name: 'Gimje-si'),
      (code: '4', name: 'Namwon-si'),
      (code: '5', name: 'Muju-gun'),
      (code: '6', name: 'Buan-gun'),
      (code: '7', name: 'Sunchang-gun'),
      (code: '8', name: 'Wanju-gun'),
      (code: '9', name: 'Iksan-si'),
      (code: '10', name: 'Imsil-gun'),
      (code: '11', name: 'Jangsu-gun'),
      (code: '12', name: 'Jeonju-si'),
      (code: '13', name: 'Jeongeup-si'),
      (code: '14', name: 'Jinan-gun'),
    ],
    '38': [
      (code: '1', name: 'Gangjin-gun'),
      (code: '2', name: 'Goheung-gun'),
      (code: '3', name: 'Gokseong-gun'),
      (code: '4', name: 'Gwangyang-si'),
      (code: '5', name: 'Gurye-gun'),
      (code: '6', name: 'Naju-si'),
      (code: '7', name: 'Damyang-gun'),
      (code: '8', name: 'Mokpo-si'),
      (code: '9', name: 'Muan-gun'),
      (code: '10', name: 'Boseong-gun'),
      (code: '11', name: 'Suncheon-si'),
      (code: '12', name: 'Sinan-gun'),
      (code: '13', name: 'Yeosu-si'),
      (code: '16', name: 'Yeonggwang-gun'),
      (code: '17', name: 'Yeongam-gun'),
      (code: '18', name: 'Wando-gun'),
      (code: '19', name: 'Jangseong-gun'),
      (code: '20', name: 'Jangheung-gun'),
      (code: '21', name: 'Jindo-gun'),
      (code: '22', name: 'Hampyeong-gun'),
      (code: '23', name: 'Haenam-gun'),
      (code: '24', name: 'Hwasun-gun'),
    ],
    '39': [
      (code: '3', name: 'Seogwipo-si'),
      (code: '4', name: 'Jeju-si'),
    ],
  },
};

List<AreaCode> getSiDoCodes({String languageCode = 'ko'}) =>
    siDoCodes[languageCode]!;

/// Returns a list of AreaCode for the Si/Gun/Gu area code from the [siDo] code.
List<AreaCode> getSiGunGuCodes({
  String languageCode = 'ko',
  required String siDo,
}) =>
    siGunGuCodes[languageCode]![siDo]!;

/// Returns the name of the Si/Do area code from the [code].
///
/// If somehow the [code] is not found, it throws an exception.
///
/// If the [languageCode] is not found, it defaults to empty string ''.
String getSiDoNameFromCode({required String code, String languageCode = 'ko'}) {
  AreaCode sido = getSiDoCodes(languageCode: languageCode).firstWhere(
    (address) => address.code == code,
    orElse: () => (code: '', name: ''),
  );
  return sido.name;
}

/// Returns the name of the Si/Gun/Gu area code from the [code].
///
/// If somehow the [code] is not found, it throws an exception.
String getSiGunGuNameFromCode(
    {required String siDo, required String code, String languageCode = 'ko'}) {
  List<AreaCode> siGunGuCodes =
      getSiGunGuCodes(languageCode: languageCode, siDo: siDo);

  AreaCode siGunGu = siGunGuCodes.firstWhere(
    (address) => address.code == code,
  );
  return siGunGu.name;
}

/// [regionSiDo] is the AreaCode of the Si/Do area code from the first region code of [siDo].
///
///
///
AreaCode getSiDo(String languageCode, String code) {
  return getSiDoCodes(languageCode: languageCode).firstWhere(
    (e) => e.code == code,
  );
}

////
AreaCode getSiGunGu(String languageCode, String siDo, String code) {
  return getSiGunGuCodes(languageCode: languageCode, siDo: siDo).firstWhere(
    (e) => e.code == code,
  );
}
