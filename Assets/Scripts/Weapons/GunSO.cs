using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "ScriptableObjects/Gun")]
public class GunSO : ScriptableObject
{
    public Gun.GunType type;

    public Gun.ShootingMode shootingMode;

    public int gunCost;
    public int ammoCost;

    public int damage;

    public int maxMagSize;
    public int maxStorageSize;

    public float fireRate; //bullets per second

    public AudioClip shootSound;
    public AudioClip reloadSound;
}
