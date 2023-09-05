using UnityEngine;
using UnityEngine.UI;

public class PlayerStats : MonoBehaviour
{
    private static PlayerStats Instance;
    
    private static int _roundsSurvived;
    private static int _enemiesKilled;
    private static int _bulletsShot;
    private static int _pointsEarned;
    
    public static int roundsSurvived
    {
        get { return _roundsSurvived; }
        set
        {
            _roundsSurvived = value;
            Instance.roundsSurvivedText.text = $"Rounds survived: {value}";
        }
    }
       
    public static int enemiesKilled
    {
        get { return _enemiesKilled; }
        set
        {
            _enemiesKilled = value;
            Instance.enemiesKilledText.text = $"Enemies killed: {value}";
        }
    }
        
    public static int bulletsShot
    {
        get { return _bulletsShot; }
        set
        {
            _bulletsShot = value;
            Instance.bulletsShotText.text = $"Bullets shot: {value}";
        }
    }

    public static int pointsEarned
    {
        get { return _pointsEarned; }
        set
        {
            _pointsEarned = value;
            Instance.pointsEarnedText.text = $"Points earned: {value}";
        }
    }


    public Text roundsSurvivedText, enemiesKilledText, bulletsShotText, pointsEarnedText;

    private void Awake()
    {
        Instance = this;
    }
}
