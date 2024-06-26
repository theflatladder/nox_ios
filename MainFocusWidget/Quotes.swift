//
//  Quotes.swift
//  Nox
//
//  Created by Александр Новиков on 23.01.2024.
//

import Foundation

class Quotes{
    
    static func getRandomQuote() -> String{
        String(rawQuotes.split(separator: "\n").randomElement() ?? "")
    }
    
    private static let rawQuotes = """
1. Have a firm handshake.
2. Look people in the eye.
3. Sing in the shower.
4. Own a great stereo system.
5. If in a fight, hit first and hit hard.
6. Keep secrets.
7. Never give up on anybody. Miracles happen everyday.
8. Always accept an outstretched hand.
9. Be brave. Even if you’re not, pretend to be. No one can tell the difference.
10. Whistle.
11. Avoid sarcastic remarks.
12. Choose your life’s mate carefully. From this one decision will come 90 per cent of all your happiness or misery.
13. Make it a habit to do nice things for people who will never find out.
14. Lend only those books you never care to see again.
15. Never deprive someone of hope; it might be all that they have.
16. When playing games with children, let them win.
17. Give people a second chance, but not a third.
18. Be romantic.
19. Become the most positive and enthusiastic person you know.
20. Loosen up. Relax. Except for rare life-and-death matters, nothing is as important as it first seems.
21. Don’t allow the phone to interrupt important moments. It’s there for our convenience, not the caller’s.
22. Be a good loser.
23. Be a good winner.
24. Think twice before burdening a friend with a secret.
25. When someone hugs you, let them be the first to let go.
26. Be modest. A lot was accomplished before you were born.
27. Keep it simple.
28. Beware of the person who has nothing to lose.
29. Don’t burn bridges. You’ll be surprised how many times you have to cross the same river.
30. Live your life so that your epitaph could read, No Regrets
31. Be bold and courageous. When you look back on life, you’ll regret the things you didn’t do more than the ones you did.
32. Never waste an opportunity to tell someone you love them.
33. Remember no one makes it alone. Have a grateful heart and be quick to acknowledge those who helped you.
34. Take charge of your attitude. Don’t let someone else choose it for you.
35. Visit friends and relatives when they are in hospital; you need only stay a few minutes.
36. Begin each day with some of your favourite music.
37. Once in awhile, take the scenic route.
38. Send a lot of Valentine cards. Sign them, ‘Someone who thinks you’re terrific.’
39. Answer the phone with enthusiasm and energy in your voice.
40. Keep a note pad and pencil on your bed-side table. Million-dollar ideas sometimes strike at 3 a.m.
41. Show respect for everyone who works for a living, regardless of how trivial their job.
42. Send your loved ones flowers. Think of a reason later.
43. Make someone’s day by paying the toll for the person in the car behind you.
44. Become someone’s hero.
45. Marry only for love.
46. Count your blessings.
47. Compliment the meal when you’re a guest in someone’s home.
48. Wave at the children on a school bus.
49. Remember that 80 per cent of the success in any job is based on your ability to deal with people.
50. Don’t expect life to be fair.
51. Show up for yourself.
52. Performance without motivation.
53. Don’t practice what you don’t want to become.
54. It is what it is.
"""
    
    
}
